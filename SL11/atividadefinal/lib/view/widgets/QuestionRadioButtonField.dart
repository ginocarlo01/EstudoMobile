import 'package:atividadefinal/bloc/answer_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/question.dart';
import 'package:flutter/material.dart';

class QuestionRadioButtonField extends StatelessWidget {
  final Question question;
  final int questionIndex;

  const QuestionRadioButtonField({
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
        _buildRadioButtons(),
      ],
    );
  }

  Widget _buildRadioButtons() {
    List<Widget> radioButtons = [];
    for (int i = 0; i < question.alternatives.length; i++) {
      radioButtons.add(
        Row(
          children: [
            BlocBuilder<ManageBloc, ManageState>(
              builder: (context, state) {
                List answer = state.answers.getAnswer(questionIndex);
                return Radio<int>(
                  value: i,
                  groupValue: answer.isNotEmpty ? answer.first : -1,
                  onChanged: (int? value) {
                    if (value != null) {
                      BlocProvider.of<ManageBloc>(context).add(
                        SetAnswer(
                          question: questionIndex,
                          value: value,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            Text(question.alternatives[i]),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: question.subTitulo,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(children: radioButtons),
      ),
    );
  }
}
