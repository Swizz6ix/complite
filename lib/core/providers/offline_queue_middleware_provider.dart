import 'package:complite/core/middlewares/offline_queue_middleware.dart';
import 'package:complite/core/providers/in_memory_queue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineQueueMiddlewareProvider = Provider((_) {
  final queue = InMemoryQueueRepository();
  
  return OfflineQueueMiddleware(queue);
});