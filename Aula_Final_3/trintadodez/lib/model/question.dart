enum QuestionType {
  singleShort, // Pergunta de resposta única e curta
  singleLong,  // Pergunta de resposta única e longa
  multiple,    // Pergunta de múltipla escolha
  text         // Pergunta que permite uma resposta em texto
}

class Question {
  final String titulo; // Título principal da pergunta
  final String subTitulo; // Subtítulo ou descrição adicional
  final List<String> alternatives; // Lista de alternativas ou opções de resposta
  final QuestionType type; // Tipo da pergunta, usando a enumeração QuestionType

  Question({
    required this.titulo,
    required this.subTitulo,
    required this.alternatives,
    required this.type,
  });
}
