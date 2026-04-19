import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/providers/network_info.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class ReplayEngine {
  final QueueRepository _queue;
  final NetworkInfo _network;
  final EventBus _bus;

  bool _isRunning = false;

  ReplayEngine(this._queue, this._network, this._bus);

  Future<void> replay() async {
    if (_isRunning) return;
    _isRunning = true;

    try {
      if (!await _network.isConnected) return;
  
      final events = await _queue.getPending();

      // FIFO ordering
      events.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      for (final event in events) {
        await _processEvent(event);
      }
    } finally {
      _isRunning = false;
    }
  }

  Future<void> _processEvent(CompanyEvent event) async {
    try {
      await _queue.markProcessing(event.requestId);

      final result = await _bus.dispatch(event);

      if (result is Success) {
      await _queue.markCompleted(event.requestId);
      } else {
        Failure(requestId: event.requestId, errorMessage: result.toString());
      }
    } catch (e) {
      final retries = event.retryCount + 1;

      await _queue.incrementRetry(event.requestId);

      if (retries >= 3) {
        await _queue.moveToDeadLetter(event);
        return;
      }

      final delay = _backoffDelay(retries);
      await Future.delayed(delay);
    }
  }

  Duration _backoffDelay(int retryCount) {
    final base = 500; //ms
    final cap = 30_000; // 30s max
    final delay = base * (1 << retryCount);

    return Duration(milliseconds: delay.clamp(0, cap));
  }
}