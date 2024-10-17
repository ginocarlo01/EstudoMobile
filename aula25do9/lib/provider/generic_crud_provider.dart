import 'package:aula25do9/model/note.dart';

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();

  GenericCrudProvider._createInstance();

  Map<String, Note> database = {};
  int numInsertions = 0;

  Future<Note> getNote(String noteId) async {
    return database[noteId] ?? Note.withData(title: "Nao existe no BD");
  }

  Future<String> insertNote(Note note) async {}

  Future<String> updateNote(String noteId, Note note) async {}

  Future<String> deleteNote(String noteId) async {}

  Future<List<Note>> getNoteList() async {}
}