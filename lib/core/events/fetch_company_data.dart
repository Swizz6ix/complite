import 'package:complite/core/events/cacheable_event.dart';
import 'package:complite/core/events/retryable_event.dart';
import 'package:complite/core/events/serializable_event.dart';

base class FetchCompanyData extends RetryableEvent<FetchCompanyData> {
  final String companyId;
  // final int page;
  // final int limit;
  static const eventType = 'FetchCompanyData';
  FetchCompanyData(
    this.companyId, {
      // this.page = 1,
      // this.limit = 5,
      super.requestId, 
      super.stopwatch, 
      super.retryCount
  });

  @override
  String get type => eventType;

  @override
  FetchCompanyData createInternal({
    required String requestId, 
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

  @override
  Map<String, dynamic> toCacheKey() => {
    'companyId': companyId,
  };
}