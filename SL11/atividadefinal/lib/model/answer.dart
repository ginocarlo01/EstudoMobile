class Answer {
  int numQuestions = 0;
  List<List<dynamic>> answerList = []; 

  Answer({required this.numQuestions}){
    answerList = List.generate(numQuestions, (_) => []);
  }

  Answer.withData({required List<List<dynamic>> answerList}){
    this.answerList = answerList;
    numQuestions = answerList.length;
  }

  List getAnswer(int i){
    return answerList[i];
  }

  void setAnswer(int i, int j){
    answerList[i] = [j];
  }

  void writeAnswer(int i, String j){
    answerList[i] = [j];
  }

  void swapAnswer(int i, int j){
    if(answerList[i].contains(j)){
      answerList[i].remove(j);
    }
    else{
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