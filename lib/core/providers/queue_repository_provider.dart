import 'package:complite/core/providers/in_memory_queue_repository.dart';

final queueRepositoryProvider = Provider((ref) {
  return InMemoryQueueRepository();
});