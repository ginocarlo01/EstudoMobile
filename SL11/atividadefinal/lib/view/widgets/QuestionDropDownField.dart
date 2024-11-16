import 'package:atividadefinal/bloc/answer_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/question.dart';
import 'package:flutter/material.dart';

class QuestionDropDownField extends StatelessWidget {
  final Question question;
  final int questionIndex;

  const QuestionDropDownField({
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
        _buildDropDown(),
      ],
    );
  }

  Widget _buildDropDown() {
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
            return DropdownButtonFormField<int>(
              value: answer.isNotEmpty ? answer.first : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  BlocProvider.of<ManageBloc>(context).add(
                    SetAnswer(
                      question: questionIndex,
                      value: newValue,
                    ),
                  );
                }
              },
              items: List.generate(
                question.alternatives.length,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text(question.alternatives[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
