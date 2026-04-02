import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cancellation_token.dart';

class CancellationMiddleware implements Middleware {
  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next, {
    CancellationToken? token,
  }) async {
    token?.throwIfCancelled(); // before execution
    final result = await next(event);
    token?.throwIfCancelled(); // After execution

    return result;
  }
}