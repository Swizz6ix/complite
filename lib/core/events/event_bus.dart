import 'dart:async';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_pipeline.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/registrations/middleware_registry.dart';
import 'package:complite/core/utilities/cancellation_token.dart';
import 'package:complite/core/states/results.dart';

class EventBus {
  final Map<Type, MiddlewareRegistry> _pipelines;
  final Map<Type, EventHandler> _handlers;



  EventBus({
    required Map<Type, MiddlewareRegistry> pipelines,
    required Map<Type, EventHandler> handlers,
  }) : _pipelines = pipelines,
       _handlers = handlers;

  Future<Results> dispatch<E extends CompanyEvent<E>, R>(
    E event, {
    CancellationToken? token,
    }) async {
      print('received');
      final handler = _handlers[E] as EventHandler;
      final pipeline = _pipelines[E] as MiddlewareRegistry;

      return pipeline.execute(
        event, 
        handler.handle
      );
    }
}
