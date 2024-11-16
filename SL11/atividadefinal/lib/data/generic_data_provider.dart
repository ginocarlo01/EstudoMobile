import 'dart:async';
import '../model/answer.dart';
import '../model/answer_collection.dart';

class GenericDataProvider {
  int numInsertions = 0;
  Map<String, List<List<dynamic>>> _database = {};
  StreamController<Map<String, dynamic>> _controller = StreamController.broadcast();

  Future<String> insertAnswer(Answer answer) async {
    String answerId = 'answer_${numInsertions++}';
    
    _database[answerId] = answer.answerList;
    
    numInsertions++;

    _controller.add({
      'answerId': answerId,
      'answer': answer,
    });

    return answerId;

  }

  Future<String> updateAnswer(String answerId, Answer answer) async {
    _database[answerId] = answer.answerList;

    _controller.add({
      'answerId': answerId,
      'answer': answer,
    });

    return answerId;
  }

  Future<String> deleteAnswer(String answerId) async {
    _database.remove(answerId);

    _controller.add({
      'answerId': answerId,
      'answer': null,
    });

    return answerId;
  }

  Future<Answer> getAnswer(String answerId) async {
    
    if(!_database.containsKey(answerId)){
      return Answer(numQuestions: 0);
    }
    else{
      //pode dar problema aqui ! 
      return Answer.withData(answerList: _database[answerId]!);
    }
  }

  Future<AnswerCollection> getAllAnswers() async {
    AnswerCollection collection = AnswerCollection();
    _database.forEach((chave, valor){
      collection.insertAnswerOfId(chave, Answer.withData(answerList: _database[chave]!));
    });
    return collection;
  }

  notify(String answerId, Answer? answer) async{
    _controller.add({
      'answerId': answerId,
      'answer': answer,
    });
  }

  Stream<Map<String, dynamic>> get stream => _controller.stream;

}