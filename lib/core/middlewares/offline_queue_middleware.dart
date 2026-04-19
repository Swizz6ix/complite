import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class OfflineQueueMiddleware implements Middleware {
  final QueueRepository _queue;

  OfflineQueueMiddleware(this._queue);

  @override
  MiddlewarePhase phase = MiddlewarePhase.resilience;

  @override
  int orderInPhase = 50;

  @override
  Future<Results<T>> handle<T>(
    CompanyEvent event,
    Future<Results<T>> Function(CompanyEvent event) next,
  ) async {
    print("enter offline");
    try {
      final result = await next(event);
      print("exit offline");
      return result;
    } catch (e, s) {
      print("offline failed $e");
      print(s);
      await _queue.enqueue(event);

      return Failure(
        requestId: event.requestId,
        errorMessage: "event enqueued",
      );
    }
  }
}