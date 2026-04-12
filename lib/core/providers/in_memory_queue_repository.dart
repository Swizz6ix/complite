import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/event_status.dart';
import 'package:complite/core/utilities/queue_item.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';


class InMemoryQueueRepository implements QueueRepository {
  final List<QueueItem> _queue = [];

  @override
  Future<void> enqueue(CompanyEvent event) async {
    _queue.add(
      QueueItem(
        event: event,
        requestId: event.requestId
      )
    );
  }

  @override
  Future<List<CompanyEvent>> getPending() async {
    return _queue
      .where((q) => q.status == EventStatus.pending)
      .map((q) => q.event)
      .toList(growable: false);
  }

  @override
  Future<void> markProcessing(String requestId) async {
    final item = _find(requestId);
    item?.status = EventStatus.processing;
  }

  @override
  Future<void> markCompleted(String requestId) async {
    final item = _find(requestId);
    item?.status = EventStatus.completed;
  }

  @override
  Future<void> markFailed(String requestId) async {
    final item = _find(requestId);
    item?.status = EventStatus.failed;
  }

  @override
  Future<void> incrementRetry(String requestId) async {
    final item = _find(requestId);

    if (item != null) item.retryCount++;
  }

  QueueItem? _find(String requestId) {
    try {
      return _queue.firstWhere((q) => q.requestId == requestId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> remove(String requestId) async {
    _queue.removeWhere((q) => q.requestId == requestId);
  }
}