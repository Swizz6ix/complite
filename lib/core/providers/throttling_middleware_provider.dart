import 'package:complite/core/middlewares/throttling_middleware.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final throttlingMiddlewareProvider = Provider((_) {
  print("throttling");
  return ThrottlingMiddleware();
});