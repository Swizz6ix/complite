import 'package:complite/core/providers/cache_read_middleware_provider.dart';
import 'package:complite/core/providers/cache_write_middleware_provider.dart';
import 'package:complite/core/providers/cancellation_middleware_provider.dart';
import 'package:complite/core/providers/concurrency_queue_middleware_provider.dart';
import 'package:complite/core/providers/debouncing_middleware_provider.dart';
import 'package:complite/core/providers/deduplication_middleware_provider.dart';
import 'package:complite/core/providers/network_guard_middleware_provider.dart';
import 'package:complite/core/providers/offline_queue_middleware_provider.dart';
import 'package:complite/core/providers/performance_middleware_provider.dart';
import 'package:complite/core/providers/retry_middleware_provider.dart';
import 'package:complite/core/providers/throttling_middleware_provider.dart';
import 'package:complite/core/providers/timeout_middleware_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final middlewareGroupProvider = Provider((ref) {
  return [
    ref.read(deduplicationMiddlewareProvider),
    ref.read(cacheReadMiddlewareProvider),
    ref.read(networkGuardMiddlewareProvider),
    ref.read(debouncingMiddlewareProvider),
    ref.read(throttlingMiddlewareProvider),
    ref.read(cancellationMiddlewareProvider),
    ref.read(concurrencyQueueMiddlewareProvider),
    ref.read(offlineQueueMiddlewareProvider),
    ref.read(retryMiddlewareProvider),
    ref.read(timeoutMiddlewareProvider),
    ref.read(performanceMiddlewareProvider),
    ref.read(cacheWriteMiddlewareProvider),
  ];
});