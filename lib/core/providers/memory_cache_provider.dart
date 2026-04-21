import 'package:complite/core/utilities/in_memory_cache_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memoryCacheProvider = Provider<InMemoryCacheStore>((ref) {
  return InMemoryCacheStore();
});