import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/middlewares/pipeline.dart';
import 'package:complite/core/providers/pipeline_registrations_provider.dart';
import 'package:complite/core/registrations/handle_registrations_provider.dart';
import 'package:complite/core/registrations/middleware_registry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventBusProvider = Provider<EventBus>((ref) {
  final handlerRegs = ref.read(handlerRegistrationsProvider);
  final pipelineRegs = ref.read(pipelineRegistrationProvider);

  final Map<Type, EventHandler> handlers = {};

  for (final reg in handlerRegs) {
    handlers.putIfAbsent(reg.eventType, () => reg.handler);
  }

  final Map<Type, MiddlewareRegistry> pipelines = {};
  for (final pipe in pipelineRegs) {
    pipelines[pipe.eventType] = pipe.pipeline;
  }

  return EventBus(
    pipelines: pipelines, 
    handlers: handlers
  );
});