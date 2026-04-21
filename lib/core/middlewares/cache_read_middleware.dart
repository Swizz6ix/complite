import 'dart:async';
import 'dart:convert';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cache_entry.dart';
import 'package:complite/core/utilities/cache_store.dart';
import 'package:complite/core/utilities/event_key.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

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
  Future<R> handle<R>(
    CompanyEvent event,
    Future<R> Function(CompanyEvent) next,
  ) async {
    final key = eventKey(event);

    // Read cache
    final cached = await _store.get<R>(key);
    print("read cache .. $cached");

    if (cached != null && !cached.isExpired(ttl)) {
      print("[CACHE-READ][$key] HIT!");

      // optional Stale-While-Revalidate
      unawaited(_refresh(event, next, key));

      return (cached.data as List)
        .map((e) => CompanyDto.fromJson(e as Map<String, dynamic>))
        .toList() as R;
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
    Future<R> Function(CompanyEvent) next,
    String key,
  ) async {
    if (_inFlight.containsKey(key)) return;

    final future = () async {
      try {
        final fresh = await next(event.create());

        await _store.set(key, CacheEntry(fresh));
        print("CACHE REFRESHED!!");
      } catch (e) {
        print("cache refresh failed");
      } finally {
        _inFlight.remove(key);
      }
    }();

    _inFlight[key] = future;
  }
}