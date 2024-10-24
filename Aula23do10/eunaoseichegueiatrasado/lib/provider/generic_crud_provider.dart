import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/note.dart';

class GenericCrudProvider {
  static GenericCrudProvider helper = GenericCrudProvider._createInstance();
  final Dio _dio = Dio();

  final CollectionReference noteCollection = FirebaseFirestore.instance.collection("notes");
  
  String uid = "default";

  GenericCrudProvider._createInstance();


 

  Future<Note> getNote(String noteId) async {
    DocumentSnapshot response = await noteCollection.doc(uid).collection("my_notes").doc(noteId).get();
    Note note = Note.fromMap(response.data());
    note.noteId = noteId;
    return note;
  }

  Future<String> insertNote(Note note) async {
    noteCollection.doc(uid).collection("my_notes").add(
      note.toMap()
    );
    
    return '1';
  }

  Future<String> updateNote(String noteId, Note note) async {

    noteCollection.doc(uid).collection("my_notes").doc(noteId).update(note.toMap());
    return noteId;
    
  }
  Future<String> deleteNote(String noteId) async {
    noteCollection.doc(uid).collection("my_notes").doc(noteId).delete();
    return noteId;
  }

  Future<List<Note>> getNoteList() async {
    
    QuerySnapshot querySnapshot = await noteCollection.doc(uid).collection("my_notes").get();
    
    List<Note> noteList = [];
    for(var doc in querySnapshot.docs)
    {
        Note note = Note.fromMap(doc.data());
        note.noteId = doc.id;
        noteList.add(note);
    }
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
