import 'dart:async';
import '../model/answer.dart';
import '../model/answer_collection.dart';

class GenericDataProvider {
  int numInsertions = 0; // Contador de inserções para gerar IDs únicos
  final Map<String, List<dynamic>> _database = {}; // Banco de dados em memória
  final StreamController<List<dynamic>> _controller = StreamController.broadcast(); // Controlador da Stream

  // Retorna a Stream para que a interface gráfica possa ouvir as mudanças
  Stream<List<dynamic>> get stream => _controller.stream;

  // Método para inserir uma resposta
  Future<String> insertAnswer(Answer answer) async {
    final answerId = 'answer_${numInsertions++}'; // Gera um ID único
    _database[answerId] = answer.answerList; // Armazena a lista de respostas
    await _notify(answerId, answer); // Notifica os ouvintes
    return answerId;
  }

  // Método para atualizar uma resposta existente
  Future<String> updateAnswer(String answerId, Answer answer) async {
    if (_database.containsKey(answerId)) {
      _database[answerId] = answer.answerList; // Atualiza a resposta
      await _notify(answerId, answer); // Notifica os ouvintes
      return answerId;
    }
    throw Exception('Answer ID não encontrado.');
  }

  // Método para excluir uma resposta
  Future<String> deleteAnswer(String answerId) async {
    if (_database.containsKey(answerId)) {
      _database.remove(answerId); // Remove a resposta
      await _notify(answerId, null); // Notifica a exclusão
      return answerId;
    }
    throw Exception('Answer ID não encontrado.');
  }

  // Método para obter uma resposta específica pelo ID
  Future<Answer> getAnswer(String answerId) async {
    if (_database.containsKey(answerId)) {
      final answerData = _database[answerId];
      if (answerData is List<List<dynamic>>) {
        return Answer.withData(numQuestions: answerData.length, answers: answerData);
      }
    }
    return Answer(numQuestions: 0); // Retorna uma Answer vazia se o ID não existir
  }

  // Método para obter todas as respostas armazenadas
  Future<AnswerCollection> getAllAnswers() async {
    final answerCollection = AnswerCollection();
    _database.forEach((id, answerList) {
      if (answerList is List<List<dynamic>>) {
        answerCollection.insertAnswerOfId(id, Answer.withData(numQuestions: answerList.length, answers: answerList));
      }
    });
    return answerCollection;
  }

  // Método privado para enviar notificações para a Stream
  Future<void> _notify(String answerId, Answer? answer) async {
    _controller.add([answerId, answer]); // Adiciona o ID e a resposta na Stream
  }
}
