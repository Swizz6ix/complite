import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_store.dart';

class HybridCacheStore  implements CacheStore {
  final CacheStore memory;
  final CacheStore disk;

  HybridCacheStore({
    required this.memory,
    required this.disk,
  });

  @override
  Future<CacheEntry<T>?> get<T>(String key) async {
    print("hybrid");
    final mem = await memory.get<T>(key);
    if (mem != null) return mem;

    final persisted = await disk.get<T>(key);
    if (persisted != null) {
      await memory.set<T>(key, persisted);
    }

    return persisted;
  }

  @override
  Future<void> set<T>(String key, CacheEntry<T> value) async {
    await memory.set<T>(key, value);
    await disk.set<T>(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await memory.remove(key);
    await disk.remove(key);
  }
}