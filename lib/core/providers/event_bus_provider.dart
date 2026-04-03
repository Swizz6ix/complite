import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/middlewares/pipeline.dart';
import 'package:complite/core/registrations/handle_registrations_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventBusProvider = Provider<EventBus>((ref) {
  final registration = ref.read(handlerRegistrationsProvider);

  final Map<Type, List<EventHandler>> handlers = {};

  for (final reg in registration) {
    handlers.putIfAbsent(reg.eventType, () => []).add(reg.handler);
  }

  final bus = EventBus(
    middlewares: deFaultPipeline.all, 
    handlers: handlers,
  );

  return bus;
});