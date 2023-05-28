import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class NoteLocalDB {
  final String dbName = 'note_local_db';
  final String tableName = 'notes';

  Future<Database> _initNoteLocalDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          create table $tableName (
            id integer primary key autoincrement,
            title text not null,
            content text not null,
            createdTime text not null
          )
        ''');
      },
      version: 1,
    );
  }

  Future<List<Note>> getAllNote() async {
    final db = await _initNoteLocalDB();
    final List<Map<String, dynamic>> result =
        await db.query(tableName, orderBy: 'id desc');

    return List.generate(result.length, (index) {
      return Note.fromMap(result[index]);
    });
  }

  Future<void> insertNote(Note note) async {
    final db = await _initNoteLocalDB();
    await db.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNote(Note note) async {
    final db = await _initNoteLocalDB();
    await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [
        note.id,
      ],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await _initNoteLocalDB();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Note> getNoteById(int id) async {
    final db = await _initNoteLocalDB();
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return Note.fromMap(result.first);
  }
}
