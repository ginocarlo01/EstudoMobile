import 'package:aula911/bloc/red_bloc.dart';
import 'package:aula911/view/receive_state.dart';
import 'package:aula911/view/send_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {return RedBloc(RedState(amount: 25));
    
    },
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Column(
        children: [
          Expanded(child: SendEvent()),
          Expanded(child: ReceiveState())
        ],
      ),
    ),
    );
  }
}