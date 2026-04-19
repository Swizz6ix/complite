import 'dart:convert';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/registrations/event_factory_registory.dart';
import 'package:complite/core/states/event_status.dart';
import 'package:complite/core/utilities/queue_item.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';
import 'package:isar/isar.dart';

class IsarQueueRepository implements QueueRepository {
  final Isar isar;
  final EventFactoryRegistory registory;

  IsarQueueRepository(this.isar, this.registory);

  @override
  Future<void> enqueue(CompanyEvent event) async {
    final mapper = registory.get(event.type);

    final entity = QueueItem()
      ..requestId = event.requestId
      ..eventType = event.type
      ..payload = jsonEncode(mapper.toJson(event))
      ..version = mapper.version
      ..retryCount = 0
      ..status = EventStatus.pending
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.queueItems.put(entity);
    });
  }

  @override
  Future<List<CompanyEvent>> getPending() async {
    final items = await isar.queueItems
      .filter()
      .statusEqualTo(EventStatus.pending)
      .findAll();

    return items.map(_toEvent).toList();
  }

  CompanyEvent _toEvent(QueueItem entity) {
    final mapper = registory.get(entity.eventType);
    final json = jsonDecode(entity.payload);

    return mapper.fromJson(json);
  }

  @override
  Future<void> markProcessing(String requestId) async {
    await _updateStatus(requestId, EventStatus.processing);
  }

  @override
  Future<void> markCompleted(String requestId) async {
    await _updateStatus(requestId, EventStatus.completed);
  }

  @override
  Future<void> markFailed(String requestId) async {
    await _updateStatus(requestId, EventStatus.failed);
  }

  @override
  Future<void> incrementRetry(String requestId) async {
    final item = await _find(requestId);
    if (item == null) return;

    // Exponential backoff
    final delay = Duration(seconds: (2 << item.retryCount));

    await isar.writeTxn(() async {
      item.retryCount++;
      item.nextRetryAt = DateTime.now().add(delay);

      await isar.queueItems.put(item);
    });
  }

  @override
  Future<void> remove(String requestId) async {
    final item = await _find(requestId);
    if (item == null) return;

    await isar.writeTxn(() async {
      await isar.queueItems.delete(item.id);
    });
  }

  @override
  Future<void> moveToDeadLetter(CompanyEvent event) async {
    final item = await _find(event.requestId);
    if (item == null) return;

    await isar.writeTxn(() async {
      item.status = EventStatus.failed;
      item.nextRetryAt = null;

      await isar.queueItems.put(item);
    });
  }

  @override
  Future<List<CompanyEvent>> getDeadLetter() async {
    final items = await isar.queueItems
      .filter()
      .statusEqualTo(EventStatus.failed)
      .findAll();

    return items.map(_toEvent).toList();
  }

  Future<void> _updateStatus(String requestId, EventStatus status) async {
    final item = await _find(requestId);
    if (item == null) return;

    await isar.writeTxn(() async {
      item.status = status;
      await isar.queueItems.put(item);
    });
  }

  Future<QueueItem?> _find(String requestId) async {
    return isar.queueItems
      .filter()
      .requestIdEqualTo(requestId)
      .findFirst();
  }
}