import 'package:complite/core/middlewares/cancellation_middleware.dart';
import 'package:complite/core/middlewares/concurrency_queue_middleware.dart';
import 'package:complite/core/middlewares/debouncing_middleware.dart';
import 'package:complite/core/middlewares/deduplication_middleware.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/middlewares/performance_middleware.dart';
import 'package:complite/core/middlewares/retry_middleware.dart';
import 'package:complite/core/middlewares/throttling_middleware.dart';
import 'package:complite/core/middlewares/timeout_middleware.dart';

class Pipeline {
  final List<Middleware> pre;
  final List<Middleware> control;
  final List<Middleware> execution;
  final List<Middleware> post;

  Pipeline({
    required this.pre,
    required this.control,
    required this.execution,
    required this.post,
  });

  List<Middleware> get all =>
    [...pre, ...control, ...execution, ...post ];
}

final deFaultPipeline = Pipeline(
  pre: [
    DeduplicationMiddleware(),
    // CacheMiddleware(),
  ], 

  control: [
    DebouncingMiddleware(),
    ThrottlingMiddleware(),
    CancellationMiddleware(),
    ConcurrencyQueueMiddleware(),
  ], 

  execution: [
    RetryMiddleware(maxRetries: 3),
    TimeoutMiddleware(timeout: Duration(seconds: 10)),
  ], 

  post: [
    PerformanceMiddleware(),
    // LoggingMiddleware(),
    // CacheMiddleware(),
  ]
);