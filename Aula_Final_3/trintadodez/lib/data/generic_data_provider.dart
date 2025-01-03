import 'dart:async';
import '../model/answer.dart';
import '../model/answer_collection.dart';

class GenericDataProvider {
  // Contador de inserções para gerar IDs únicos
  int numInsertions = 0;

  // Banco de dados em memória
  final Map<String, List> _database = {};

  // Controlador da Stream para notificação de atualizações
  final StreamController<List<dynamic>> _controller = StreamController.broadcast();

  // Retorna a Stream para que a interface gráfica possa ouvir as mudanças
  Stream<List<dynamic>> get stream => _controller.stream;

  // Método para inserir uma resposta
  Future<String> insertAnswer(Answer answer) async {
    // Gera um ID único baseado no contador
    final answerId = 'answer_${numInsertions++}';

    // Armazena a lista de respostas no banco de dados
    _database[answerId] = answer.answerList;

    // Notifica os ouvintes sobre a nova resposta inserida
    await _notify(answerId, answer);

    return answerId;
  }

  // Método para atualizar uma resposta existente
  Future<String> updateAnswer(String answerId, Answer answer) async {
    if (_database.containsKey(answerId)) {
      // Atualiza a resposta no banco de dados
      _database[answerId] = answer.answerList;

      // Notifica os ouvintes sobre a atualização
      await _notify(answerId, answer);

      return answerId;
    }
    throw Exception('Answer ID não encontrado.');
  }

  // Método para excluir uma resposta
  Future<String> deleteAnswer(String answerId) async {
    if (_database.containsKey(answerId)) {
      // Remove a resposta do banco de dados
      _database.remove(answerId);

      // Notifica os ouvintes sobre a exclusão (com null para indicar a remoção)
      await _notify(answerId, null);

      return answerId;
    }
    throw Exception('Answer ID não encontrado.');
  }

  // Método para obter uma resposta específica pelo ID
  Future<Answer> getAnswer(String answerId) async {
  if (_database.containsKey(answerId)) {
    final answerData = _database[answerId];
    if (answerData is List<List<dynamic>>) {
      // Define o número de perguntas com base no tamanho de `answerData`
      int numQuestions = answerData.length;
      return Answer.withData(numQuestions: numQuestions, answers: answerData);
    }
  }
  // Retorna uma Answer vazia se o ID não existir ou os dados não forem válidos
  return Answer(numQuestions: 0);
}


  // Método para obter todas as respostas armazenadas
Future<AnswerCollection> getAllAnswers() async {
  final answerCollection = AnswerCollection();

  // Adiciona todas as respostas do banco de dados na AnswerCollection
  _database.forEach((id, answerList) {
    if (answerList is List<List<dynamic>>) {
      // Define o número de perguntas com base no tamanho de `answerList`
      int numQuestions = answerList.length;
      answerCollection.insertAnswerOfId(id, Answer.withData(numQuestions: numQuestions, answers: answerList));
    }
  });

  return answerCollection;
}


  // Método privado para enviar notificações para a Stream
  Future<void> _notify(String answerId, Answer? answer) async {
    // Adiciona o ID e a resposta na Stream para atualização da interface gráfica
    _controller.add([answerId, answer]);
  }
}
