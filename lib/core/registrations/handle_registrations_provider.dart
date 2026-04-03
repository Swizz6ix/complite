import 'package:complite/core/providers/fetch_company_handler.dart';
import 'package:complite/core/registrations/event_handler_registration.dart';
import 'package:complite/core/registrations/fetch_company_registration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final handlerRegistrationsProvider = Provider<List<EventHandlerRegistration>>((ref) {
  return [
    FetchCompanyRegistration(ref.read(fetchCompanyHandlerProvider)),
  ];
});