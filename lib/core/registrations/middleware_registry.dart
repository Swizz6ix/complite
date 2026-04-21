import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

class MiddlewareRegistry<T>{
  final Map<MiddlewarePhase, List<Middleware>> _middlewares;

  MiddlewareRegistry(this._middlewares);
  
  factory MiddlewareRegistry.fromList(List<Middleware> middlewares) {
    final map = <MiddlewarePhase, List<Middleware>>{};

    for (final phase in MiddlewarePhase.values) {
      map[phase] = [];
    }

    for (final m in middlewares) {
      map.putIfAbsent(m.phase, () => []);
      map[m.phase]!
        ..add(m)
        ..sort((a, b) => a.orderInPhase.compareTo(b.orderInPhase));
    }

    return MiddlewareRegistry(map);
  }
      
  Future<T> execute (
    CompanyEvent event, 
    Future<T> Function(CompanyEvent event) handler
    ) {
      final ordered = MiddlewarePhase.values
        .expand((phase) => _middlewares[phase]!)
        .toList();

    return _dispatch(ordered, handler)(event);
  }


  Future<T> Function(CompanyEvent) _dispatch(
    List<Middleware> middleware,
    Future<T> Function(CompanyEvent) handler,
  ) {
    return middleware.reversed.fold(
      handler,
      (next, middleware) {
        return (event) => middleware.handle(event, next);
      }
    );
  }
}