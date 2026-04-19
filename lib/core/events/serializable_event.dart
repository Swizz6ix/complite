import 'package:complite/core/events/company_event.dart';

abstract class SerializableEvent<T extends CompanyEvent<T>> {
  int get version;
  
  Map<String, dynamic> toJson( T event);
  T fromJson(Map<String, dynamic> json);
}