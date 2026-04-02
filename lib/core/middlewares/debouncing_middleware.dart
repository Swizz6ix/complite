import 'dart:async';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/results.dart';

class DebouncingMiddleware implements Middleware {
  final Duration delay;
  Timer? _timer;

  DebouncingMiddleware({
    this.delay = const Duration(milliseconds: 300),
  });

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next
  ) async {
    final completer = Completer<Results<T>>();

    // cancel previous timer
    _timer?.cancel();

    _timer = Timer(delay, () async {
      try {
        final result = await next(event);
        completer.complete(result);
      } catch (e, st) {
        completer.completeError(e, st);
      }
    });

    return completer.future;
  }
}