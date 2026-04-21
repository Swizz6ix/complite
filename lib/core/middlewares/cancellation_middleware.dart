import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cancellation_token.dart';

class CancellationMiddleware implements Middleware {
  @override
  MiddlewarePhase phase = MiddlewarePhase.rateLimit;

  @override
  int orderInPhase = 38;
  @override
  Future<T> handle<T>(
    CompanyEvent event,
    Future<T> Function(CompanyEvent event) next, {
    CancellationToken? token,
  }) async {
    token?.throwIfCancelled(); // before execution
    final result = await next(event);
    token?.throwIfCancelled(); // After execution

    return result;
  }
}