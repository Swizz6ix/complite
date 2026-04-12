import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/results.dart';

abstract class EventHandler<E extends CompanyEvent<E>, R> {
  Future<Results> handle(E event);
}