import 'dart:async';
import 'dart:convert';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_store.dart';
import 'package:complite/core/utilities/event_key.dart';

class CacheReadMiddleware implements Middleware {
  final CacheStore _store;
  final Duration ttl;
  final _inFlight = <String, Future<void>>{};

  CacheReadMiddleware(
    this._store, 
    {
      this.ttl = const Duration(minutes: 5)
    }
  );

  @override
  MiddlewarePhase phase = MiddlewarePhase.preProcess;

  @override
  final int orderInPhase = 15;

  @override
  Future<Results<R>> handle<R>(
    CompanyEvent event,
    Future<Results<R>> Function(CompanyEvent) next,
  ) async {
    final key = eventKey(event);

    // Read cache
    final cached = await _store.get<R>(key);

    if (cached != null && !cached.isExpired(ttl)) {
      print("[CACHE-READ][$key] HIT!");

      // optional Stale-While-Revalidate
      unawaited(_refresh(event, next, key));

      return Success(event.requestId, cached.data);
    }

    if (cached != null && cached.isExpired(ttl)) {
      await _store.remove(key);
    }

    print("CACHE MISS!");

    // Fetch
    return await next(event);
  }

  Future<void> _refresh<R>(
    CompanyEvent event,
    Future<Results<R>> Function(CompanyEvent) next,
    String key,
  ) async {
    if (_inFlight.containsKey(key)) return;

    final future = () async {
      try {
        final fresh = await next(event.create());

        if (fresh is Success<R>) {
          await _store.set(key, CacheEntry(fresh.data));
          print("CACHE REFRESHED");
        }
      } finally {
        _inFlight.remove(key);
      }
    }();

    _inFlight[key] = future;
  }
}