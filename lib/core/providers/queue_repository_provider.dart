import 'package:complite/core/providers/in_memory_queue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final queueRepositoryProvider = Provider((ref) {
  return InMemoryQueueRepository();
});