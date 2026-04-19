import 'package:complite/core/events/serializable_event.dart';
import 'package:complite/core/states/event_status.dart';

abstract class CompanyEvent<T> {
  final String requestId;
  final Stopwatch? stopwatch;
  final DateTime createdAt;

  String get type;

  EventStatus status;
  int retryCount;

  CompanyEvent({
    String? requestId,
    DateTime? createdAt,
    this.status = EventStatus.pending,
    this.retryCount = 0,
    this.stopwatch,
    }) : requestId = requestId ?? _generateId(), 
    createdAt = createdAt ?? DateTime.now();

    static String _generateId() {
      return DateTime.now().microsecondsSinceEpoch.toString();
    }

    /// Child must implement this
    T create({Stopwatch? stopwatch}) {
      return createInternal(
        requestId: _generateId(),
        stopwatch: stopwatch,
      );
    }

    T createInternal({
      required String requestId, 
      Stopwatch? stopwatch,
      int? retryCount,
    });

    T copyWith({
      Stopwatch? stopwatch,
      int? retryCount,
    }) {
      return createInternal(
        requestId: requestId, 
        stopwatch: stopwatch ?? this.stopwatch,
        retryCount: retryCount ?? this.retryCount,
      );
    }
    
    Map<String, dynamic> toCacheKey();
}