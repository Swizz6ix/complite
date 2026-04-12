import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/event_status.dart';

class QueueItem {
  final CompanyEvent event;
  final String requestId;
  int retryCount;
  EventStatus status;

  QueueItem({
    required this.event,
    required this.requestId,
    this.retryCount = 0,
    this.status = EventStatus.pending,
  });
}