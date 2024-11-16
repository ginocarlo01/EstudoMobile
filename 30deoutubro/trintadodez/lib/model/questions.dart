import 'question.dart';

class Questions {
  final List<Question> questionList; // Armazena todas as perguntas do formulário
  final List<int> breakpoints; // Define pontos de quebra para dividir o formulário em seções

  Questions({
    required this.questionList,
    required this.breakpoints,
  });
}
