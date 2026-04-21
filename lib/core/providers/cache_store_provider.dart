import 'package:complite/core/providers/database_provider.dart';
import 'package:complite/core/providers/memory_cache_provider.dart';
import 'package:complite/core/utilities/hybrid_cache_store.dart';
import 'package:complite/core/utilities/in_memory_cache_store.dart';
import 'package:complite/core/utilities/isar_cache_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheStoreProvider = Provider((ref) {
  final isar = ref.read(databaseProvider);
  final memory = ref.read(memoryCacheProvider);

  return HybridCacheStore(
    memory: memory,
    disk: IsarCacheStore(isar),
  );
});