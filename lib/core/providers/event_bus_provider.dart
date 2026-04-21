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

  print("pre-reg");
  for (final reg in handlerRegs) {
    print("reg");
    handlers.putIfAbsent(reg.eventType, () => reg.handler);
  }

  print("pre-pipe");
  final Map<Type, MiddlewareRegistry> pipelines = {};
  for (final pipe in pipelineRegs) {
    print("pipe");
    pipelines[pipe.eventType] = pipe.pipeline;
  }

  print("event bus done");
  final bus = EventBus(
    pipelines: pipelines, 
    handlers: handlers
  );

  print("after bus $bus");
  return bus;
});