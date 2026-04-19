import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/states/results.dart';

abstract class EventHandler{
  Future<Results> handle(CompanyEvent event);
}