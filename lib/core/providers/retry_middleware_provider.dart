import 'package:complite/core/middlewares/retry_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final retryMiddlewareProvider = Provider((_) {
  print("retry");
  return RetryMiddleware();
});