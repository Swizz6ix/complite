import 'package:complite/core/middlewares/cancellation_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cancellationMiddlewareProvider = Provider((_) {
  print("cancelled");
  return CancellationMiddleware();
});