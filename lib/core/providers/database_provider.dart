import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final databaseProvider = Provider<Isar>((ref) {
  throw StateError("databaseProvider must be overriden in ProviderScope"); // initialize properly
});