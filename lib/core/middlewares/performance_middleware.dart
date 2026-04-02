
import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/results.dart';

class PerformanceMiddleware extends Middleware {
  // final _logger = Logger('CompanyApp.Performance');

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await next(event);
      return result;
    } finally {
      stopwatch.stop();
      // _logger.info("[${event.requestId}] TIME -> ${stopwatch.elapsedMilliseconds}ms");
    }
  }
}