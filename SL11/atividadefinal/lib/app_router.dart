import 'package:flutter/material.dart';
import 'model/question.dart';
import 'model/questions.dart';
import 'data/question_provider.dart';
import 'view/widgets/QuestionRadioButtonField.dart';
import 'view/widgets/QuestionTextField.dart';
import 'view/widgets/QuestionDropDownField.dart';
import 'view/widgets/QuestionCheckBoxField.dart';
import 'view/screen/questions_screen.dart';

class AppRouter {
  static AppRouter _instance = AppRouter._internal();
  AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  // Método para gerenciar as rotas
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => _buildQuestionsScreen());
      default:
        return _getQuestionScreenRoute(settings);
    }
  }

  // Método para construir a tela de perguntas dinamicamente
  Widget _buildQuestionsScreen() {
    List<Widget> localBucket = [];

    // Obtendo a lista de perguntas
    Questions questions = QuestionProvider.helper.questions;
    
    // Adicionando widgets para cada tipo de pergunta
    for (int i = 0; i < questions.questionList.length; i++) {
      Question question = questions.questionList[i];
      switch (question.type) {
        case QuestionType.singleShort:
          localBucket.add(QuestionRadioButtonField(
            question: question, questionIndex: i));
          break;
        case QuestionType.singleLong:
          localBucket.add(QuestionDropDownField(
            question: question, questionIndex: i));
          break;
        case QuestionType.multiple:
          localBucket.add(QuestionCheckBoxField(
            question: question, questionIndex: i));
          break;
        case QuestionType.text:
          localBucket.add(QuestionTextField(
            question: question, questionIndex: i));
          break;
        default:
          localBucket.add(Container());
      }
    }

    // Criando a tela com as perguntas como TabBarView
    return QuestionsScreen(children: localBucket);
  }

  // Método para gerenciar a navegação para cada tela de perguntas
  Route<dynamic> _getQuestionScreenRoute(RouteSettings settings) {
    // Caso precise de uma rota específica para perguntas, você pode customizar aqui
    return MaterialPageRoute(builder: (_) => _buildQuestionsScreen());
  }
}