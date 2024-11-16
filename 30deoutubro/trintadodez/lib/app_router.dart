import '../bloc/counter_bloc.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/my_home_page_screen.dart';

class AppRouter {
  CounterBloc counterBloc = CounterBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/": // Raiz
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: counterBloc,
                  child: const MyHomePage(
                    title: 'Morino',
                  ),
                ));
      case "/create": // Raiz
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: counterBloc,
                  child: const MyHomePage(
                    title: 'ROTA CREATE',
                  ),
                ));
      case "/vazio":
        return MaterialPageRoute(
            builder: (_) => Container(
                  color: Colors.blue,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const Text("Erro"));
    }
  }

  dispose() {
    counterBloc.close();
  }
}
