import 'dart:async';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_pipeline.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/registrations/middleware_registry.dart';
import 'package:complite/core/utilities/cancellation_token.dart';
import 'package:complite/core/states/results.dart';

class EventBus {
  final Map<Type, MiddlewareRegistry<dynamic>> _pipelines;
  final Map<Type, EventHandler<dynamic>> _handlers;


  EventBus({
    required Map<Type, MiddlewareRegistry<dynamic>> pipelines,
    required Map<Type, EventHandler<dynamic>> handlers,
  }) : _pipelines = pipelines,
       _handlers = handlers;

  Future<dynamic> dispatch<R>(
    CompanyEvent event, {
    CancellationToken? token,
    }) async {
      final eventType = event.runtimeType;
      print('received');
      final handler = _handlers[eventType];
      if (handler == null) {
        throw StateError("No handler registered for $eventType");
      }

      final pipeline = _pipelines[eventType];
      if (pipeline == null) {
        throw StateError("No pipeline registered fo $eventType");
      }

      return pipeline.execute(
        event, 
        handler.handle
      );
    }
}
