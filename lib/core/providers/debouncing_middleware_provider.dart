import 'package:complite/core/middlewares/debouncing_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debouncingMiddlewareProvider = Provider((_) {
  return DebouncingMiddleware();
});