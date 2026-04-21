import 'dart:async';
import 'dart:collection';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class ConcurrencyQueueMiddleware implements Middleware {
  final int maxConcurrent;
  int _running = 0;
  final Queue<Future<void> Function()> _queue = Queue();

  ConcurrencyQueueMiddleware({this.maxConcurrent = 3});

  @override
  MiddlewarePhase phase = MiddlewarePhase.concurrency;

  @override
  int orderInPhase = 40;

  @override
  Future<T> handle<T> (
    CompanyEvent event,
    Future<T> Function(CompanyEvent event) next,
  ) {
    print("started concurrent");
    final completer = Completer<T>();
    
    print("about to add to queue");
    _queue.add(() async {
      try {
        final result = await next(event);

        if (!completer.isCompleted) {
          completer.complete(result);
        }
      } catch (e, s) {
        if (!completer.isCompleted) {
          completer.completeError(e, s);
        }
      } finally {
        _running--;
        scheduleMicrotask(_processQueue);
      }
    });

    print("queue added");
    
    scheduleMicrotask(_processQueue);
    print("process start running ${_queue.length}");
    return completer.future;
  }

  void _processQueue(){
    while (_running < maxConcurrent && _queue.isNotEmpty) {
      final task = _queue.removeFirst();
      _running++;
      print("launch task");
      task();
      print("task completer");
    }
  }
}