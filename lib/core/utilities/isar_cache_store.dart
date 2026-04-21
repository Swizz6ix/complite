import 'dart:convert';

import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_item.dart';
import 'package:complite/core/utilities/cache_store.dart';
import 'package:isar/isar.dart';

class IsarCacheStore implements CacheStore{
  final Isar isar;

  IsarCacheStore(this.isar);

  @override
  Future<CacheEntry<T>?> get<T>(String key) async {
    print("read disk key --> $key");
    final item = await isar.cacheItems
      .filter()
      .keyEqualTo(key)
      .findFirst();
      
    if (item == null) return null;

    return CacheEntry<T>(
      jsonDecode(item.json) as T,
    );
  }

  @override
  Future<void> set<T>(String key, CacheEntry<T> value) async {
    await isar.writeTxn(() async {
      await isar.cacheItems.put(
        CacheItem()
          ..key = key
          ..json = jsonEncode(value.data)
          ..timestamp = value.timestamp,
      );
    });
  }

  @override
  Future<void> remove(String key) async {
    await isar.writeTxn(() async {
      await isar.cacheItems
        .filter()
        .keyEqualTo(key)
        .deleteAll();
    });
  }
}