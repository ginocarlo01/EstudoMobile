import 'package:atividadefinal/bloc/answer_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/question.dart';
import 'package:flutter/material.dart';

class QuestionTextField extends StatelessWidget {
  final Question question;
  final int questionIndex;

  const QuestionTextField({
    super.key,
    required this.question,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return _buildQuestion();
  }

  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (question.titulo != "")
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              question.titulo,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        _buildTextField(),
      ],
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: question.subTitulo,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: BlocBuilder<ManageBloc, ManageState>(
          builder: (context, state) {
            List answer = state.answers.getAnswer(questionIndex);
            TextEditingController controller = TextEditingController(
              text: answer.isNotEmpty ? answer.first : '',
            );
            return TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (String newValue) {
                BlocProvider.of<ManageBloc>(context).add(
                  WriteAnswer(
                    question: questionIndex,
                    value: newValue,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
