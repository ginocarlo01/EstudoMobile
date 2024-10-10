import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'chat_bloc.dart';
import 'chat_provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: HtmlWidget(state.chatValue),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Digite sua mensagem',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final message = _textEditingController.text;
                    if (message.isNotEmpty) {
                      ChatProvider().sendMessage(message);
                      _textEditingController.clear();
                    }
                  },
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: HtmlWidget('<h2>Mensagens</h2>'),
          ),
        ],
      ),
    );
  }
}
