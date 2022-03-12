import 'package:sqflite/sqflite.dart';
import 'package:sqlite_database/models/note.dart';
import 'package:sqlite_database/storage/db/db_operations.dart';
import 'package:sqlite_database/storage/db/db_provider.dart';

class NoteDBController extends DBOperations<Note>{
Database database = DBProvider().database;

  @override
  Future<bool> delete(int id) async {
    return await database.delete('notes',where: 'id = ?',whereArgs: [id]) > 0;
  }

  @override
  Future<int> create(Note object) async {
   return await database.insert('notes', object.toMap());
  }

  @override
  Future<List<Note>> read() async {
    var notes = await database.query('notes');
    return notes.map((note) => Note.fromMap(note)).toList();
  }

  @override
  Future<Note?> show(int id) async {
     var notes = await database.query('notes',where: 'id = ?',whereArgs: [id]);
     if (notes.isNotEmpty) {
       return Note.fromMap(notes.first);
     }
     return null;
  }

  @override
  Future<bool> update(Note object) async {
    return await database.update('notes', object.toMap(), where: 'id = ?', whereArgs: [object.id]) > 0;
  }

}