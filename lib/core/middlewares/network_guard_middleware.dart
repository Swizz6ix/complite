import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/providers/network_info.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class NetworkGuardMiddleware implements Middleware {
  final NetworkInfo network;

  NetworkGuardMiddleware(this.network);

  @override
  MiddlewarePhase phase = MiddlewarePhase.guard;

  @override
  int orderInPhase = 20;

  @override
  Future<Results<R>> handle<R>(
    CompanyEvent event,
    Future<Results<R>> Function(CompanyEvent) next,
  ) async {
    if (!await network.isConnected) {
      return Failure(
        requestId: event.requestId,
        errorMessage: "No internet connection"
      );
    }

    return next(event);
  }
}