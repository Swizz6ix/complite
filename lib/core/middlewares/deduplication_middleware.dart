
import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class DeduplicationMiddleware implements Middleware {
  final _activeRequests = <String, Future<void>>{};

  @override
  MiddlewarePhase phase = MiddlewarePhase.preProcess;

  @override
  int orderInPhase = 10;

  @override
  Future<Results<T>> handle<T>(
    CompanyEvent event,
    Future<Results<T>> Function(CompanyEvent event) next,
  ) {
    if (_activeRequests.containsKey(event.requestId)) {
      return _activeRequests[event.requestId] as Future<Results<T>>;
    }

    final future = next(event);
    _activeRequests[event.requestId] = future;

    future.whenComplete(() => _activeRequests.remove(event.requestId));

    return future;
  }
}