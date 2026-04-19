import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/registrations/event_factory_registory.dart';
import 'package:complite/core/registrations/fetch_company_data_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventFactoryRegistryProvider = Provider<EventFactoryRegistory>((ref) {
  final registry = EventFactoryRegistory();

  registry.register<FetchCompanyData>(
    FetchCompanyData.eventType,
    FetchCompanyDataMapper()
  );

  return registry;
});