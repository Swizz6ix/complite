import 'dart:convert';
import 'package:complite/core/events/company_event.dart';

String eventKey(CompanyEvent event) {
  final payload = jsonEncode(event.toCacheKey());
  return "${event.type}-$payload";
}