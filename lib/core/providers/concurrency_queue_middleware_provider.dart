import 'package:complite/core/middlewares/concurrency_queue_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final concurrencyQueueMiddlewareProvider = Provider((_) {
  return ConcurrencyQueueMiddleware();
});