
import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class ThrottlingMiddleware implements Middleware {
  final Duration interval;
  DateTime? _lastExecution;

  ThrottlingMiddleware({this.interval = const Duration(seconds: 10)});

  @override
  MiddlewarePhase phase = MiddlewarePhase.rateLimit;

  @override
  int orderInPhase = 35;

  @override
  Future<Results<T>> handle<T>(
    CompanyEvent event,
    Future<Results<T>> Function(CompanyEvent event) next
  ) async {
    final now = DateTime.now();

    if (_lastExecution == null || now.difference(_lastExecution!) >= interval) {
      _lastExecution = now;
      return next(event);
    } else {
      return Future.error('Event throttled');
    }
  }
}