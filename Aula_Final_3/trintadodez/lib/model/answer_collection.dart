import 'answer.dart';

class AnswerCollection {
  final List<String> idList = []; // Lista de identificadores únicos para cada conjunto de respostas
  final List<Answer> answerList = []; // Lista de respostas associadas a cada identificador em idList

  // Retorna o número de conjuntos de respostas
  int length() => idList.length;

  // Retorna a resposta na posição index da lista answerList
  Answer? getAnswerAtIndex(int index) {
    if (index >= 0 && index < answerList.length) {
      return answerList[index];
    }
    return null;
  }

  // Retorna o ID na posição index da lista idList
  String? getIdAtIndex(int index) {
    if (index >= 0 && index < idList.length) {
      return idList[index];
    }
    return null;
  }

  // Retorna o índice do ID fornecido em idList
  int getIndexOfId(String id) => idList.indexOf(id);

  // Atualiza a resposta associada ao id fornecido
  void updateAnswerOfId(String id, Answer answer) {
    int index = getIndexOfId(id);
    if (index != -1) {
      answerList[index] = answer;
    }
  }

  // Remove o conjunto de respostas e o ID associado
  void deleteAnswerOfId(String id) {
    int index = getIndexOfId(id);
    if (index != -1) {
      idList.removeAt(index);
      answerList.removeAt(index);
    }
  }

  // Insere uma nova resposta associada ao id se ele ainda não existir em idList
  void insertAnswerOfId(String id, Answer answer) {
    if (!idList.contains(id)) {
      idList.add(id);
      answerList.add(answer);
    }
  }

  // Atualiza ou insere um conjunto de respostas associado a um ID específico
  void updateOrInsertAnswerOfId(String id, Answer answer) {
    int index = getIndexOfId(id);
    if (index != -1) {
      answerList[index] = answer;
    } else {
      idList.add(id);
      answerList.add(answer);
    }
  }
}
