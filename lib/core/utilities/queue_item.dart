import 'dart:convert';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/serializable_event.dart';
import 'package:complite/core/states/event_status.dart';
import 'package:isar/isar.dart';

part 'queue_item.g.dart';

@collection
class QueueItem {
  static const int collectionId = 8159347730612;
  late String requestId;
  late String eventType; // for deserialization
  late String payload; // JSON serialized event
  String? failureReason;
  
  @enumerated
  late EventStatus status;
  Id id = Isar.autoIncrement;
  late int version;
  int retryCount = 0;
  DateTime createdAt = DateTime.now();
  DateTime? nextRetryAt;

  QueueItem();

  /// Factory to convert domain -> persistence
  factory QueueItem.fromEvent(
    CompanyEvent event,
    SerializableEvent mapper
  ) {
    return QueueItem()
      ..requestId = event.requestId
      ..eventType = event.runtimeType.toString()
      ..payload = jsonEncode(mapper.toJson(event))
      ..status = EventStatus.pending
      ..failureReason = "max retries execeeded";
  }
}