import 'dart:convert';

import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/serializable_event.dart';
import 'package:complite/core/registrations/Event_factory.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteQueueRepository implements QueueRepository {
  final Database db;

  SqliteQueueRepository(this.db);

  @override
  Future<void> enqueue(CompanyEvent event) async {
    final serializable = event as SerializableEvent;

    await db.insert('event_queue', {
      'type': serializable.type,
      'payload': jsonEncode(serializable.toJson()),
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<List<CompanyEvent>> getPending() async {
    final rows = await db.query(
      'event_queue',
      orderBy: 'created_at ASC',
    );

    return rows.map((row) {
      return EventFactory.fromJson(
        row['type'] as String,
        jsonDecode(row['payload'] as String),
      );
    }).toList();
  }

  @override
  Future<void> remove(CompanyEvent event) async {
    final serializabe = event as SerializableEvent;

    await db.delete(
      'event_queue',
      where: 'type = ? AND payload = ?',
      whereArgs: [
        serializabe.type,
        jsonEncode(serializabe.toJson()),
      ],
    );
  }
}