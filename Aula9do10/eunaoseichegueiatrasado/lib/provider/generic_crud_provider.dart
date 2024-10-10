import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

import '../model/note.dart';

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();
  final Dio _dio = Dio();
  
  GenericCrudProvider._createInstance();


/*
  Map<String, Note> database = {};
  Future<Note> getNote(String noteId) async {}
  Future<String> insertNote(Note note) async {}
  Future<String> updateNote(String noteId, Note note) async {}
  Future<String> deleteNote(String noteId) async {}
  Future<List<Note>> getNoteList() async {}
*/

 

  Future<Note> getNote(String noteId) async {
    Response response = await _dio.get("https://si700s2-default-rtdb.firebaseio.com/.json");
    Note note = Note.fromMap(response.data);
    note.noteId = noteId;
    return note;
  }

  Future<String> insertNote(Note note) async {

    _dio.post("https://si700s2-default-rtdb.firebaseio.com/.json",
    data: note.toMap());
  /*
    String key = numInsertions.toString();
    note.noteId = key;
    database[key] = note;
    numInsertions++;
    _controller.sink.add(key);
    return key;
    */
    _controller.sink.add("1");
    return '1';
  }

  Future<String> updateNote(String noteId, Note note) async {

    _dio.put("https://si700s2-default-rtdb.firebaseio.com/$noteId/.json", 
    data: note.toMap());

    /*
    note.noteId = noteId;
    database[noteId] = note;
    */
    _controller.sink.add(noteId);
    return noteId;
    
  }

  Future<String> deleteNote(String noteId) async {
   _dio.delete("https://si700s2-default-rtdb.firebaseio.com/$noteId/.json");

    //database.remove(noteId);
    _controller.sink.add(noteId);
    return noteId;
  }

  Future<List<Note>> getNoteList() async {
    Response response=await _dio.get("https://si700s2-default-rtdb.firebaseio.com/.json");
    List<Note> noteList = [];
    response.data.forEach((k,v)
    {
        Note note = Note.fromMap(v);
        note.noteId = k;
        noteList.add(note);
    });
    return noteList;
  }

  /*
    Parte da Stream
  */
  final _random = Random();
  final StreamController _controller = StreamController();
  final _count = 0;

  final List<String> respostas = [
    "Olá, como vai você?",
    "Como posso lhe ajudar hoje?",
    "Como você está se sentindo?",
    "Qual o seu nome?",
    "Vamos nos conhecer melhor?"
  ];

  Stream get stream {
    return _controller.stream;
  }
}
