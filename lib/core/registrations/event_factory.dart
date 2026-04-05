import 'package:complite/core/events/company_event.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

class EventFactory {
  static final Map<String, Function> _registry = {
    'FetchCompanyData': (json) => CompanyDto.fromJson(json),
  };

  static CompanyEvent fromJson(String type, Map<String, dynamic> json) {
    final factory = _registry[type];

    if (factory == null) {
      throw Exception('Unknown event type: $type');
    }
    return factory(json);
  }
}