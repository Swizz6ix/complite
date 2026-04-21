import 'dart:async';
import 'dart:io';

import 'package:complite/core/errors/app_error.dart';
import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class RetryMiddleware extends Middleware{
  // final _logger = Logger("CompanyApp.RetryMiddleware");
  final int maxRetries;

  RetryMiddleware({this.maxRetries = 3});

  @override
  MiddlewarePhase phase = MiddlewarePhase.resilience;

  @override
  int orderInPhase = 55;

  @override
  Future<T> handle<T>(
    CompanyEvent event,
    Future<T> Function(CompanyEvent event) next,
  ) async {
    int attempt = 0;

    while (true) {
      try {
        return await next(event);
      } catch (e) {
        if (e is SocketException || e is TimeoutException) {
          rethrow; // let API handle it
        }

        if (e is ParsingError || e is BusinessLogicError) {
          rethrow; //don't retry
        }
        attempt++;

        if (attempt >= maxRetries) rethrow;
        // _logger.info("[${event.requestId}] RETRY $attempt");
      }
    }
 }
}