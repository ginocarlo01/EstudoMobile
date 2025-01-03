import '../model/answer_collection.dart';
import '../data/generic_data_provider.dart';
import '../model/answer.dart';
import 'answer_manager.dart';

class ManageBloc {
  final GenericDataProvider _dataProvider;
  late Answer answers; // Respostas gerenciadas
  String answerId = '';

  ManageBloc(this._dataProvider, int numQuestions) {
    answers = Answer(numQuestions: numQuestions); // Inicializa com o número de perguntas
  }

  Future<void> createRecord() async {
    answerId = await _dataProvider.insertAnswer(answers); // Cria novo registro
  }

  Future<void> updateRecord(String answerId) async {
    await _dataProvider.updateAnswer(answerId, answers); // Atualiza o registro
  }

  Future<void> deleteRecord(String answerId) async {
    await _dataProvider.deleteAnswer(answerId); // Exclui o registro
  }

  void swapAnswer(int question, int value) {
    answers.swapAnswer(question, value); // Alterna a resposta
    _dataProvider.updateAnswer(answerId, answers); // Atualiza no data provider
  }

  void setAnswer(int question, int value) {
    answers.setAnswer(question, value); // Define a resposta
    _dataProvider.updateAnswer(answerId, answers); // Atualiza no data provider
  }

  void writeAnswer(int question, String value) {
    answers.writeAnswer(question, value); // Escreve a resposta
    _dataProvider.updateAnswer(answerId, answers); // Atualiza no data provider
  }
}
