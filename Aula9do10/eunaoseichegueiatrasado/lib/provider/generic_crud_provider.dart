import 'dart:async';
import 'dart:math';
import 'package:socket_io_client/socket_io_client.dart';
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
    Response response = await _dio.get("https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev/notes");
    Note note = Note.fromMap(response.data);
    note.noteId = noteId;
    return note;
  }

  Future<String> insertNote(Note note) async {

    _dio.post("https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev/notes",
    data: note.toMap());
  /*
    String key = numInsertions.toString();
    note.noteId = key;
    database[key] = note;
    numInsertions++;
    _controller.sink.add(key);
    return key;
    */
    //_controller.sink.add("1");
    return '1';
  }

  Future<String> updateNote(String noteId, Note note) async {

    _dio.put("https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev/notes/$noteId/", 
    data: note.toMap());

    /*
    note.noteId = noteId;
    database[noteId] = note;
    */
    //_controller.sink.add(noteId);
    return noteId;
    
  }
  Future<String> deleteNote(String noteId) async {
   _dio.delete("https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev/notes/$noteId");

    //database.remove(noteId);
    //_controller.sink.add(noteId);
    return noteId;
  }

  Future<List<Note>> getNoteList() async {
    Response response=await _dio.get("https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev/notes");
    List<Note> noteList = [];
    response.data.forEach((k,v)
    {
        Note note = Note.fromMap(v);
        note.noteId = k;
        noteList.add(note);
    });
    return noteList;
  }
//flutter pub add socket_io_client
  /*
    Parte da Stream
  */
  final _random = Random();
  final _count = 0;

  final List<String> respostas = [
    "Olá, como vai você?",
    "Como posso lhe ajudar hoje?",
    "Como você está se sentindo?",
    "Qual o seu nome?",
    "Vamos nos conhecer melhor?"
  ];


   StreamController? _controller;

  Stream get stream {

    if(_controller == null){
      _controller = StreamController();

      Socket socket = io(
        "https://7c3c2ca4-f4d1-4a1a-8e5b-a0bfd8fb439f-00-196n8wf7zcll2.worf.replit.dev",
        OptionBuilder().setTransports(['websocket']).build());
      
      socket.on('server_information', (data) {
        _controller!.sink.add("gino");
      });

    }
    return _controller!.stream;
  }
}
