import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/events/serializable_event.dart';

class FetchCompanyDataMapper implements SerializableEvent<FetchCompanyData> {
  @override
  int get version => 1;

  @override
  Map<String, dynamic> toJson(FetchCompanyData event) {
    return {
      'companyId': event.companyId,
      'requestId': event.requestId,
      'retryCount': event.retryCount,
    };
  }

  @override
  FetchCompanyData fromJson(Map<String, dynamic> json) {
    return FetchCompanyData(
      json['companyId'],
      requestId: json['requestId'],
      retryCount: json['retryCount'] ?? 0,
    );
  }
}