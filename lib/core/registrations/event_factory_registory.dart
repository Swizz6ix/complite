import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/serializable_event.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

class EventFactoryRegistory {
  final Map<String, SerializableEvent> _mappers = {};

  void register <T extends CompanyEvent>(
    String eventType,
    SerializableEvent mapper
  ) {
    _mappers[eventType] = mapper;
  }

 SerializableEvent get(String eventType) {
  final mapper = _mappers[eventType];

  if (mapper == null) {
    throw Exception("No mapper registered for $eventType");
  }
  return mapper;
 }
}