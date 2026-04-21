import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_store.dart';
import 'package:complite/core/utilities/event_key.dart';

class CacheWriteMiddleware implements Middleware{
  final CacheStore _store;

  CacheWriteMiddleware(this._store);

  @override
  MiddlewarePhase phase = MiddlewarePhase.postProcess;

  @override
  int orderInPhase = 80;

  @override
  Future<R> handle<R>(
    CompanyEvent event,
    Future<R> Function(CompanyEvent) next,
  ) async {
    final key = eventKey(event);
    final result = await next(event);

    await _store.set(key, CacheEntry(result));
    print("cache written ==> $_store");
    return result;
  }
}