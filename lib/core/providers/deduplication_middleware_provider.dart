import 'package:complite/core/middlewares/deduplication_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deduplicationMiddlewareProvider = Provider((_) {
  return DeduplicationMiddleware();
});