import 'package:complite/core/middlewares/cache_write_middleware.dart';
import 'package:complite/core/utilities/in_memory_cache_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheWriteMiddlewareProvider = Provider((_) {
  return CacheWriteMiddleware(InMemoryCacheStore());
});