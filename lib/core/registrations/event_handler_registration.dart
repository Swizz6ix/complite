import 'package:complite/core/handlers/event_handler.dart';

abstract class EventHandlerRegistration {
  Type get eventType;
  EventHandler get handler;
}