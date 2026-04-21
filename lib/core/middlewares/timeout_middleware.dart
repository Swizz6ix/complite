import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class TimeoutMiddleware implements Middleware {
  // final _logger = Logger('CompanyApp.TimeoutMiddleware');
  final Duration timeout;

  TimeoutMiddleware({required this.timeout});

  @override
  MiddlewarePhase phase = MiddlewarePhase.timeout;

  @override
  int orderInPhase = 60;

  @override
  Future<T> handle<T>(
    CompanyEvent event,
    Future<T> Function(CompanyEvent event) next,
  ) async {
    // _logger.info("TimeoutMiddleware START ${event.requestId}");
    
    final result = await next(event).timeout(timeout, onTimeout: () {
      // _logger.severe("TIMEOUT ${event.requestId}");
      throw Exception("[${event.requestId}] Timeout after $timeout");
    });

    // _logger.info("TimeoutMiddleware END ${event.requestId}");
    return result;
  }
}