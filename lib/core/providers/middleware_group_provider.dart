import 'package:complite/core/providers/middleware_providers.dart';
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