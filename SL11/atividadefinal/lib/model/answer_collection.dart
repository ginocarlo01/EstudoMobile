import '../model/answer.dart';

class AnswerCollection {
  List<String> idList = [];
  List<Answer> answerList = [];

  AnswerCollection(){
    idList = [];
    answerList = [];
  }

  int length(){
    return answerList.length;
  }

  Answer getAnswerAtIndex(int index){
    return answerList[index];
  }

  String getIdAtIndex(int index){
    return idList[index];
  }

  getIndexOfId(String id){
    return idList.indexOf(id);
  }

  updateAnswerOfId(String id, Answer answer){
    answerList[getIndexOfId(id)] = answer;
  }

  deleteAnswerOfId(String id){
    answerList.removeAt(getIndexOfId(id));
  }

  insertAnswerOfId(String id, Answer answer){
    if(!idList.contains(id)){
      idList.add(id);
      answerList.add(answer);
    }
  }

  void updateOrInsertAnswerOfId(String id, Answer answer) {
    int index = getIndexOfId(id);
    if (index != -1) {
      answerList[index] = answer;
    } 
    else {
      idList.add(id);
      answerList.add(answer);
    }
    }
}