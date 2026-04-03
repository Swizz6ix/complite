import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/providers/company_event_handlers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsHandlersProvider = Provider<Map<Type, List<EventHandler>>>((ref) {
  final companyHandlers = ref.read(companyEventHandlersProvider);
  
  return {
    ...companyHandlers,
  };
});