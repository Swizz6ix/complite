import 'package:complite/core/events/cacheable_event.dart';
import 'package:complite/core/events/retryable_event.dart';
import 'package:complite/core/events/serializable_event.dart';

base class FetchCompanyData extends RetryableEvent<FetchCompanyData> implements SerializableEvent {
  final String companyId;
  // final int page;
  // final int limit;
 
  FetchCompanyData(
    this.companyId, {
      // this.page = 1,
      // this.limit = 5,
      super.requestId, 
      super.stopwatch, 
      super.retryCount
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
    };
  }

  @override
  String get type => "FetchCompanyData";

  @override
  FetchCompanyData create({String? requestId, Stopwatch? stopwatch}) {
    return FetchCompanyData(
      companyId,
      // page: page,
      // limit: limit,
      requestId: requestId, 
      stopwatch: stopwatch, 
      retryCount: retryCount
    );
  }

  @override
  FetchCompanyData createWithRetry({
    String? requestId,
    Stopwatch? stopwatch,
    int? retryCount,
  }) {
    return FetchCompanyData(
      companyId,
      // page: page,
      // limit: limit,
      requestId: requestId, 
      stopwatch: stopwatch,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}