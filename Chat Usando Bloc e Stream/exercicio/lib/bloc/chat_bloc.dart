import 'package:flutter_bloc/flutter_bloc.dart';
import '../provider/chat_provider.dart';

// Definindo eventos
abstract class ChatEvent {
  final String message;
  ChatEvent(this.message);
}

class UserEvent extends ChatEvent {
  UserEvent(String message) : super(message);
}

// Definindo o estado do chat
class ChatState {
  final String chatValue;
  ChatState({this.chatValue = ''});
}

// Implementando o ChatBloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<UserEvent>((event, emit) {
      emit(ChatState(
        chatValue: "${state.chatValue}<h3 align='right'>${event.message}</h3>",
      ));
    });

    // Simulando a conexão com o ChatProvider
    final chatProvider = ChatProvider();
    chatProvider.stream.listen((message) {
      add(UserEvent(message));
    });
  }
}
