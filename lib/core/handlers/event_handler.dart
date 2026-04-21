import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/results.dart';

abstract class EventHandler<T>{
  Future<T> handle(CompanyEvent event);
}