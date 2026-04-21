import 'package:complite/core/middlewares/cache_write_middleware.dart';
import 'package:complite/core/providers/cache_store_provider.dart';
import 'package:complite/core/utilities/in_memory_cache_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheWriteMiddlewareProvider = Provider((ref) {
  final hybridStore = ref.read(cacheStoreProvider);

  print("cache about to write");
  return CacheWriteMiddleware(hybridStore);
});