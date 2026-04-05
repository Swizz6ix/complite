import 'dart:async';
import 'dart:io';

import 'package:complite/core/errors/app_error.dart';
import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/replay_engine.dart';

class RetryMiddleware extends Middleware{
  // final _logger = Logger("CompanyApp.RetryMiddleware");
  final int maxRetries;
  final ReplayEngine replay;
  bool _hasreplayed = false;

  RetryMiddleware({this.maxRetries = 3});

  @override
 Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
  E event,
  Future<Results<T>> Function(E event) next,
 ) async {
  int attempt = 0;

  while (true) {
    try {
      return await replay.replay();
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