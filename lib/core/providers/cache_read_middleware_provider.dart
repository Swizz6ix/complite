import 'package:complite/core/middlewares/cache_read_middleware.dart';
import 'package:complite/core/providers/cache_store_provider.dart';
import 'package:complite/core/utilities/in_memory_cache_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheReadMiddlewareProvider = Provider((ref) {
  final hybridStore = ref.read(cacheStoreProvider);
  print("cache about to read");
  return CacheReadMiddleware(hybridStore);
});