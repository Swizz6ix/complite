import 'package:complite/core/middlewares/timeout_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeoutMiddlewareProvider = Provider((_) {
  print("timeour");
  return TimeoutMiddleware(timeout: Duration(seconds: 10));
});