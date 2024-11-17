class Answer {
  int numQuestions = 0;
  List<List<dynamic>> answerList = [];

  Answer({required this.numQuestions}) {
    answerList = List.generate(numQuestions, (_) => []);
  }

  Answer.withData({required List<List<dynamic>> answerList}) {
    this.answerList = answerList;
    numQuestions = answerList.length;
  }

  List getAnswer(int questionIndex) {
    // Retorna a lista de respostas para a questão especificada
    if (questionIndex < answerList.length) {
      return answerList[questionIndex];
    } else {
      return [];
    }
  }

  void _expandListIfNeeded(int index) {
    // Expande a lista se o índice estiver fora dos limites
    if (index >= answerList.length) {
      answerList
          .addAll(List.generate(index + 1 - answerList.length, (_) => []));
    }
  }

  void setAnswer(int i, int j) {
    _expandListIfNeeded(i);
    answerList[i] = [j];
  }

  void writeAnswer(int questionIndex, String answer) {
    _expandListIfNeeded(questionIndex);

    if (answerList[questionIndex].isEmpty) {
      answerList[questionIndex].add(answer);
    } else {
      answerList[questionIndex][0] = answer;
    }
  }

  void swapAnswer(int i, int j) {
    _expandListIfNeeded(i);

    if (answerList[i].contains(j)) {
      answerList[i].remove(j);
    } else {
      answerList[i].add(j);
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
