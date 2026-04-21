import 'package:isar/isar.dart';

part 'cache_item.g.dart';

@collection
class CacheItem {
  Id id = Isar.autoIncrement;
  late String key;
  late String json;
  late DateTime timestamp;
}