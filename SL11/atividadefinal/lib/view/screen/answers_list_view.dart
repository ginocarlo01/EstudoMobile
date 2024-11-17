import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/answer_monitor.dart';
import '../../model/answer.dart';
import '../../model/answer_collection.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respostas'),
      ),
      body: _buildAnswersList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Cria um novo registro e navega para a tela de criação
          BlocProvider.of<MonitorBloc>(context)
              .handleAskNewList(); // Opcional, dependendo do fluxo
          Navigator.pushNamed(context, "/questions");
        },
      ),
    );
  }

  // Método para construir a lista de respostas usando BlocBuilder
  Widget _buildAnswersList() {
    return BlocBuilder<MonitorBloc, MonitorState>(
      builder: (context, state) {
        AnswerCollection answerCollection = state.answerCollection;

        if (answerCollection.length() == 0) {
          return const Center(
            child: Text('Nenhuma resposta encontrada.'),
          );
        }

        return ListView.builder(
          itemCount: answerCollection.length(),
          itemBuilder: (context, index) {
            // Obtemos a resposta e seu ID
            Answer answer = answerCollection.getAnswerAtIndex(index);
            String id = answerCollection.getIdAtIndex(index);

            return ListTile(
              title: Text('ID: $id'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Deleta o registro ao clicar no ícone
                  BlocProvider.of<MonitorBloc>(context)
                      .answerCollection
                      .deleteAnswerOfId(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Resposta $id excluída')),
                  );
                },
              ),
              onTap: () {
                // Navega para a tela de edição passando o ID da resposta
                Navigator.pushNamed(
                  context,
                  "/edit",
                  arguments: id, // Passa o ID da resposta como argumento
                );
              },
            );
          },
        );
      },
    );
  }
}
