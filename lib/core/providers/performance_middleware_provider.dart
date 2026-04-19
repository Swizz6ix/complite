import 'package:complite/core/middlewares/performance_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final performanceMiddlewareProvider = Provider((_) {
  print("performance");
  return PerformanceMiddleware();
});