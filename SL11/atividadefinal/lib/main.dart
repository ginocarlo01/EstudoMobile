import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'bloc/answer_manager.dart'; // Importe o seu ManageBloc
import 'bloc/answer_monitor.dart'; // Se necessário
import 'data/generic_data_provider.dart'; // Se necessário
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Inicializa o MonitorBloc
        BlocProvider<MonitorBloc>(
          create: (context) => MonitorBloc(),
        ),
        // Inicializa o ManageBloc com as dependências necessárias
        BlocProvider<ManageBloc>(
          create: (context) {
            // Criação do GenericDataProvider
            final dataProvider = GenericDataProvider();
            // Passando o MonitorBloc como dependência para o ManageBloc
            final monitorBloc = BlocProvider.of<MonitorBloc>(context);
            return ManageBloc(dataProvider, monitorBloc);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: AppRouter().onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}