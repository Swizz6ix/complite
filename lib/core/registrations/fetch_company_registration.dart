import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/registrations/event_handler_registration.dart';

class FetchCompanyRegistration implements EventHandlerRegistration {
  final EventHandler _handler;

  FetchCompanyRegistration(this._handler);

  @override
  Type get eventType => FetchCompanyData;

  @override
  EventHandler get handler => _handler;
}