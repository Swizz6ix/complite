import 'package:complite/core/middlewares/offline_queue_middleware.dart';
import 'package:complite/core/providers/queue_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineQueueMiddlewareProvider = Provider((ref) {
  final queue = ref.read(queueRepositoryProvider);
  print('offline');
  return OfflineQueueMiddleware(queue);
});