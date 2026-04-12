import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/providers/network_info.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class ReplayEngine {
  final QueueRepository _queue;
  final NetworkInfo _network;
  final Future<void> Function(CompanyEvent event) _dispatcher;

  bool _isRunning = false;

  ReplayEngine(this._queue, this._network, this._dispatcher);

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
      await _dispatcher(event);
      await _queue.markCompleted(event.requestId);
    } catch (e) {
      await _queue.incrementRetry(event.requestId);

      if (event.retryCount >= 3) {
        await _queue.markFailed(event.requestId);
      }
    }
  }
}