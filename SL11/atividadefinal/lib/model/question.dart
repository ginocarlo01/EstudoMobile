enum QuestionType { singleShort, singleLong, multiple, text }

class Question {
  String titulo;
  String subTitulo;
  List<String> alternatives;
  QuestionType type;

  Question(
  {required this.titulo,
  required this.subTitulo,
  required this.alternatives,
  required this.type});
}