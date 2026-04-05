abstract class SerializableEvent {
  Map<String, dynamic> toJson();
  String get type;
}