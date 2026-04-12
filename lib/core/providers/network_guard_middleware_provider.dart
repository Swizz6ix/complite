import 'package:complite/core/middlewares/network_guard_middleware.dart';
import 'package:complite/core/providers/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkGuardMiddlewareProvider = Provider((ref) {
  final network = ref.read(networkProvider);
  
  return NetworkGuardMiddleware(network);
});