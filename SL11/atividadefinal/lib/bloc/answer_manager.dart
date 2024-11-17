import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/answer.dart'; // Importe sua model Answer
import '../data/generic_data_provider.dart'; // Importe seu GenericDataProvider
import '../bloc/answer_monitor.dart'; // Importe o MonitorBloc

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  final GenericDataProvider _dataProvider;
  final MonitorBloc _monitorBloc;

  ManageBloc(this._dataProvider, this._monitorBloc)
      : super(ManageState.build(0)) {
    on<CreateRecord>((event, emit) async {
      emit(await _handleCreateRecord());
    });

    on<UpdateRecord>((event, emit) async {
      emit(await _handleUpdateRecord(event));
    });

    on<DeleteRecord>((event, emit) async {
      emit(await _handleDeleteRecord(event));
    });

    on<SwapAnswer>((event, emit) async {
      emit(await _handleSwapAnswer(event));
    });

    on<SetAnswer>((event, emit) async {
      emit(await _handleSetAnswer(event));
    });

    on<WriteAnswer>((event, emit) async {
      emit(await _handleWriteAnswer(event));
    });
  }

  // Métodos para lidar com os eventos
  Future<ManageState> _handleCreateRecord() async {
    // Cria um novo registro de resposta
    Answer newAnswer = Answer(numQuestions: state.answers.numQuestions);
    String answerId = await _dataProvider.insertAnswer(newAnswer);
    return ManageState(answers: newAnswer, answerId: answerId);
  }

  Future<ManageState> _handleUpdateRecord(UpdateRecord event) async {
    // Atualiza um registro existente
    Answer updatedAnswer = await _dataProvider.getAnswer(event.answerId);
    return ManageState(answers: updatedAnswer, answerId: event.answerId);
  }

  Future<ManageState> _handleDeleteRecord(DeleteRecord event) async {
    // Exclui o registro de resposta
    await _dataProvider.deleteAnswer(event.answerId);
    return ManageState(
        answers: Answer(numQuestions: state.answers.numQuestions),
        answerId: "");
  }

  Future<ManageState> _handleSwapAnswer(SwapAnswer event) async {
    // Troca uma resposta (múltipla escolha)
    if (event.question >= 0) {
      state.answers
          .swapAnswer(event.question, event.value); // Usando swapAnswer
      await _dataProvider.updateAnswer(state.answerId, state.answers);
    }

    return ManageState(answers: state.answers, answerId: state.answerId);
  }

  Future<ManageState> _handleSetAnswer(SetAnswer event) async {
    // Define uma resposta única (substitui a resposta existente)
    state.answers.setAnswer(
        event.question, event.value); // Usando setAnswer para única escolha
    await _dataProvider.updateAnswer(state.answerId, state.answers);
    return ManageState(answers: state.answers, answerId: state.answerId);
  }

  Future<ManageState> _handleWriteAnswer(WriteAnswer event) async {
    // Escreve uma resposta de texto
    state.answers.writeAnswer(event.question,
        event.value); // Usando writeAnswer para respostas em texto
    await _dataProvider.updateAnswer(state.answerId, state.answers);
    return ManageState(answers: state.answers, answerId: state.answerId);
  }
}

abstract class ManageEvent {}

class SwapAnswer extends ManageEvent {
  int question;
  int value;
  SwapAnswer({required this.question, required this.value});
}

class SetAnswer extends ManageEvent {
  int question;
  int value;
  SetAnswer({required this.question, required this.value});
}

class WriteAnswer extends ManageEvent {
  int question;
  String value;
  WriteAnswer({required this.question, required this.value});
}

class CreateRecord extends ManageEvent {}

class UpdateRecord extends ManageEvent {
  String answerId;
  UpdateRecord({required this.answerId});
}

class DeleteRecord extends ManageEvent {
  String answerId;
  DeleteRecord({required this.answerId});
}

class ManageState {
  late Answer answers;
  late String answerId;

  ManageState({required this.answers, required this.answerId});

  ManageState.build(int numQuestions) {
    answers = Answer(numQuestions: numQuestions);
    answerId = "";
  }
}
