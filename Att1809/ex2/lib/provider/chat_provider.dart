import 'dart:async';
import 'package:flutter/material.dart';

class ChatProvider {
  // Singleton instance
  static final ChatProvider _instance = ChatProvider._internal();
  factory ChatProvider() => _instance;
  ChatProvider._internal();

  final List<String> _messages = [];
  final StreamController<String> _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  void sendMessage(String message) {
    _messages.add(message);
    _controller.sink.add(message);
  }

  void dispose() {
    _controller.close();
  }
}
