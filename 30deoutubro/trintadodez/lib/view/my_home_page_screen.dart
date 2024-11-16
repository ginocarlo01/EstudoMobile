import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, int>(builder: (context, state) {
              return Text(
                '$state',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            ElevatedButton(
                onPressed: () {
                  /*
                  CounterBloc counterBloc =
                      BlocProvider.of<CounterBloc>(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider.value(
                      value: counterBloc,
                      child: const MyHomePage(
                        title: "Segunda Rota",
                      ),
                    );
                  }));*/
                  Navigator.pushNamed(context, "/create");
                },
                child: Text("NovaRota"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<CounterBloc>(context).add(CounterEvent.increment);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
