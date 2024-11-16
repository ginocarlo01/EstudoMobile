import 'dart:async';
import 'package:bloc/bloc.dart'; // Importando o pacote bloc
import '../model/answer_collection.dart';
import '../model/answer.dart';
import '../data/generic_data_provider.dart';

// MonitorBloc agora herda de Cubit, que lida diretamente com estados, sem a necessidade de adicionar eventos
class MonitorBloc extends Cubit<MonitorState> {
  late AnswerCollection answerCollection;
  late StreamSubscription<Map<String, dynamic>> _subscription;

  // Construtor do MonitorBloc
  MonitorBloc() : super(MonitorState(answerCollection: AnswerCollection())) {
    answerCollection = AnswerCollection();

    // Inicializa com o evento AskNewList para buscar as respostas iniciais
    handleAskNewList();

    // Inscreve-se na Stream do GenericDataProvider para receber as atualizações
    _subscription = GenericDataProvider().stream.listen((data) {
      String answerId = data['answerId'];
      Answer? answer = data['answer'];

      if (answer == null) {
        answerCollection.deleteAnswerOfId(answerId);
      } else {
        answerCollection.updateOrInsertAnswerOfId(answerId, answer);
      }

      // Atualiza o estado com a coleção atualizada
      emit(MonitorState(answerCollection: answerCollection));
    });
  }

  // Método para atualizar o estado com as respostas completas após o evento AskNewList
  Future<void> handleAskNewList() async {
    AnswerCollection collection = await GenericDataProvider().getAllAnswers();
    answerCollection = collection;
    emit(MonitorState(answerCollection: collection)); // Atualiza o estado com o novo estado
  }

  // Método para cancelar a inscrição quando o Bloc não for mais necessário
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

// Definindo o estado para MonitorBloc
class MonitorState {
  final AnswerCollection answerCollection;

  MonitorState({required this.answerCollection});
}
