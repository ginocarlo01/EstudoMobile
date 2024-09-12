import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aula_28_08/bloc/auth_bloc_intro.dart'; // Ajuste o caminho do seu BLoC
import 'package:aula_28_08/view/screens/primeira_tela.dart'; // Ajuste o caminho conforme necessário
import 'package:aula_28_08/view/wrapper.dart'; // Ajuste o caminho conforme necessário

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthBlocIntro(Unauthenticated()),
        child: Wrapper(), // Wrapper gerencia a navegação baseada no estado de autenticação
      ),
    );
  }
}
