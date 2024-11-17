import '../model/question.dart';
import '../model/questions.dart';

class QuestionProvider {
  static QuestionProvider helper = QuestionProvider._createInstance();
  QuestionProvider._createInstance();

  Questions questions = Questions(questionList: [
    Question(
        titulo: "Primeira",
        subTitulo: "",
        alternatives: ["1", "2", "3"],
        type: QuestionType.multiple),
    Question(
        titulo: "Segunda",
        subTitulo: "Tenho um subtítulo",
        alternatives: ["a", "b", "c", "d"],
        type: QuestionType.singleShort),
    Question(
        titulo: "Terceira",
        subTitulo: "Tenho um subtítulo",
        alternatives: [],
        type: QuestionType.text),
    // Adicione mais perguntas conforme necessário
  ], breakpoints: [
    1, 2, 4, 5 // Defina os pontos de quebra desejados
  ]);
}

//   Observação: Em uma aplicação real, idealmente, a QuestionProvider se comunicaria
// com um Bloc para a gestão de estado e interação com a interface gráfica. No entanto,
// como este formulário é fixo, faremos a comunicação direta com a GUI neste caso.