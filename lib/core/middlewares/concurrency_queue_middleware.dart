import 'dart:async';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class ConcurrencyQueueMiddleware implements Middleware {
  final int maxConcurrent;
  int _running = 0;
  final _queue = <Future Function()>[];

  ConcurrencyQueueMiddleware({this.maxConcurrent = 3});

  @override
  MiddlewarePhase phase = MiddlewarePhase.concurrency;

  @override
  int orderInPhase = 40;

  @override
  Future<Results<T>> handle<T> (
    CompanyEvent event,
    Future<Results<T>> Function(CompanyEvent event) next,
  ) {
    final completer = Completer<Results<T>>();

    _queue.add(() async {
      try {
        _running++;
        final result = await next(event);
        completer.complete(result);
      } catch (e, s) {
        completer.completeError(e, s);
      } finally {
        _running--;
        _processQueue();
      }
    });
    
    _processQueue();
    return completer.future;
  }

  void _processQueue(){
    while (_running < maxConcurrent && _queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      task();
    }
  }
}