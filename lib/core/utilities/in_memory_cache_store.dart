import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_store.dart';
import 'package:complite/core/utilities/type_cache_Entry.dart';

class InMemoryCacheStore implements CacheStore {
  final _map = <String, TypeCacheEntry>{};

  @override
  Future<CacheEntry<T>?> get<T>(String key) async {
    final entry = _map[key];
    print("read memory $entry ---> $key");

    if (entry == null) return null;

    if (entry.type != T) {
      throw StateError(
        "Cache type mismatch for key=$key. Expected $T got ${entry.type}",
      );
    }

    return entry.value as CacheEntry<T>;
  }

  @override
  Future<void> set<T>(String key, CacheEntry<T> value) async {
    _map[key] = TypeCacheEntry(value, T);
  }

  @override
  Future<void> remove(String key) async {
    _map.remove(key);
  }
}