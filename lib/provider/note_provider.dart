import 'package:flutter/material.dart';
import 'package:sqlite_database/controllers/note_db_controller.dart';
import 'package:sqlite_database/models/note.dart';

class NoteProvider extends ChangeNotifier {
  final NoteDBController _noteDBController = NoteDBController();
  List<Note> notes = <Note>[];

  Future<void> read() async {
    notes = await _noteDBController.read();
    notifyListeners();
  } // read

  Future<bool> create({required Note note}) async {
    int id = await _noteDBController.create(note);
    if (id != null) {
      note.id = id;
      notes.add(note);
      notifyListeners();
    }
    return id != null;
  } // create

  Future<bool> delete({required int id}) async {
    bool deleted = await _noteDBController.delete(id);
    if (deleted) {
      notes.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    return deleted;
  } // delete

  Future<bool> update({required Note note}) async {
    bool updated = await _noteDBController.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return updated;
  } // update

}
