import 'package:complite/core/providers/database_provider.dart';
import 'package:complite/core/providers/event_factory_registry_provider.dart';
import 'package:complite/features/company/data/repositories/isar_queue_repository.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueRepositoryProvider = Provider<QueueRepository>((ref) {
  
  final db = ref.read(databaseProvider);
  final registry = ref.read(eventFactoryRegistryProvider);

  return IsarQueueRepository(db, registry);
});