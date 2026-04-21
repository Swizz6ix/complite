import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';

abstract class Middleware {
  MiddlewarePhase get phase;

  int get orderInPhase => 0;

  Future<T> handle<T>(
    CompanyEvent event,
    Future<T> Function(CompanyEvent event) next,
  );
}