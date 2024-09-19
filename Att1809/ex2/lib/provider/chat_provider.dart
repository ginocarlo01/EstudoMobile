import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';  // Para decodificar JSON, se necessário
import 'package:http/http.dart' as http;

// Simulação do ChatProvider
class ChatProvider {
  // Singleton para garantir que só haja uma instância
  static final ChatProvider _instance = ChatProvider._createInstance();
  static ChatProvider get helper => _instance;
  final StreamController<String> _controller = BehaviorSubject<String>();

  // Lista de mensagens predefinidas para simular respostas do servidor
  final List<String> _messages = [
    "Olá, como vai você?",
    "Como posso lhe ajudar hoje?",
    "Como você está se sentindo?"
  ];

  // Construtor privado
  ChatProvider._createInstance() {
    // Simula respostas automáticas a cada 5 segundos
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      final randomMessage = _messages[timer.tick % _messages.length];
      _controller.sink.add(randomMessage);
    });

    // Conexão com WebSocket
    _connectToWebSocket();
  }

  // Conectar ao WebSocket
  void _connectToWebSocket() {
    IO.Socket socket = IO.io(
      "https://1ba9a98e-f785-4605-aa8b-39d46644fe96-00-2zj8tzqdbk2pg.picard.replit.dev/",
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.on('server_information', (data) {
      // Verifica o tipo de dados recebido e formata conforme necessário
      String formattedData;
      if (data is Map) {
        formattedData = data.entries.map((entry) => '${entry.key}:${entry.value}').join('; ');
      } else {
        formattedData = data.toString();
      }

      _controller.sink.add(formattedData);
    });
  }

  // Método getter para acessar a stream
  Stream<String> get stream => _controller.stream;

  // Método para adicionar uma mensagem (simulando o envio do usuário)
  void addMessage(String message) {
    _controller.sink.add(message);
  }

  // Fecha o StreamController quando não for mais necessário
  void dispose() {
    _controller.close();
  }
}

// Evento base abstrato
abstract class ChatEvent {
  final String message;

  ChatEvent({required this.message});
}

// Evento disparado quando o usuário envia uma mensagem
class UserEvent extends ChatEvent {
  UserEvent({required String message}) : super(message: message);
}

// Evento disparado quando o servidor envia uma mensagem
class ServerEvent extends ChatEvent {
  ServerEvent({required String message}) : super(message: message);
}

// Classe que mantém o estado do chat
class ChatState {
  final String chatValue;

  // Construtor com valor padrão como string vazia
  ChatState({this.chatValue = ""});
}

// BLoC que gerencia o chat
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    // Conexão com a stream do ChatProvider
    ChatProvider.helper.stream.listen((String resposta) {
      // Adiciona um evento ServerEvent ao BLoC quando uma mensagem é recebida do servidor
      add(ServerEvent(message: resposta));
    });
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    // Recupera o histórico atual do chat
    String lChat = state.chatValue;

    if (event is UserEvent) {
      // Mensagem do usuário, alinha à direita
      yield ChatState(
        chatValue: "$lChat\n<h3 align='right'>${event.message}</h3>",
      );
    } else if (event is ServerEvent) {
      // Mensagem do servidor, alinha à esquerda
      yield ChatState(
        chatValue: "$lChat\n<h3 align='left'>${event.message}</h3>",
      );
    }
  }
}
