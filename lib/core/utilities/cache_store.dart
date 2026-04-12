import 'package:complite/core/utilities/cache_entry.dart';

abstract class CacheStore {
  Future<CacheEntry<T>?> get<T>(String key);
  Future<void> set<T>(String key, CacheEntry<T> value);
  Future<void> remove(String key);
}