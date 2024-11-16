class Answer {
  final int numQuestions; // Número total de perguntas
  final List<List<dynamic>> answerList; // Lista que armazena as respostas para cada pergunta

  // Construtor que inicializa answerList com listas vazias
  Answer({required this.numQuestions}) : answerList = List.generate(numQuestions, (_) => []);

  // Construtor que inicializa answerList com uma lista de respostas já preenchida
  Answer.withData({required this.numQuestions, required List<List<dynamic>> answers})
      : answerList = List.from(answers);

  // Método para retornar a lista de respostas para a pergunta na posição i
  List<dynamic> getAnswer(int i) {
    return answerList[i];
  }

  // Método para definir a resposta para a pergunta i como a opção j
  void setAnswer(int i, int j) {
    answerList[i] = [j]; // Mantém a estrutura de lista de listas
  }

  // Método para definir a resposta para a pergunta i como uma string j
  void writeAnswer(int i, String j) {
    answerList[i] = [j]; // Mantém a estrutura de lista de listas
  }

  // Método para alternar a presença da opção j na resposta da pergunta i (para múltipla escolha)
  void swapAnswer(int i, int j) {
    if (answerList[i].contains(j)) {
      answerList[i].remove(j); // Remove se já existe
    } else {
      answerList[i].add(j); // Adiciona se não existe
    }
  }

  @override
  String toString() {
  List<String> strArray = [];
  for (int i = 0; i < answerList.length; i++) {
  String strElement = '"${answerList[i].join(",")}"';
  strArray.add(strElement);
  }
  return strArray.join(";");
  }
}
