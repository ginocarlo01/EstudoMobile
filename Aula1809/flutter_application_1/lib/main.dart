import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Random random = Random();
  final StreamController<String> controller = StreamController<String>();

  Future<void> esperar() async {
    await Future.delayed(const Duration(seconds: 3));
    print("Esperei 3 segundos");
  }

  Future<void> esperarComErro() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if(random.nextBool()){
      print("Consegui passar sem erro");
    }
    else{
      throw "Um erro conhecido";
    }
  }

  Future<String> pedirPizza() async {
    await Future.delayed(const Duration(seconds: 3));
    return "Pizza chegou";
  }

  Stream<int> torneira() async* { //* pq sao varias coisas assincronas que ele esta mandando
    int counter = 0;
    while (true){
      await Future.delayed(const Duration(seconds: 3));
      counter += 1;
      yield counter;
    } 

  }

  @override
  void initState() {
    controller.stream.listen((String value){
      print(value);
    });
  super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              esperar();
              print("Sera que eu espererei...");
            }, 
            child: Text("Esperar 3 segundos, mas nao parado")),
            ElevatedButton(onPressed: ()async{
              await esperar();
              print("Sera que eu espererei...");
            }, 
            child: Text("Esperar 3 segundos, parado")),
            ElevatedButton(onPressed: (){
              try{
              esperarComErro().onError((error, stackTrace) {
                print("Consegui capturar um erro em paralelo: ${error.toString()}");
              },);
              } catch(e){
                print("Capture ${e.toString()}");
              }
              print("Sera que eu espererei...");
            }, 
            child: Text("Esperar 3 segundos com erro, mas nao parado")),
            ElevatedButton(onPressed: ()async{
              await esperarComErro();
              print("Sera que eu espererei...");
            }, 
            
            child: Text("Esperar 3 segundos com erro, parado")),
            ElevatedButton(onPressed: (){
              var x = pedirPizza();
              print(x);
            }, 
            child: Text("Pedir pizza, mas nao parado")),
            ElevatedButton(onPressed: ()async{
              var x = await pedirPizza();
              print(x);

            }, 
            child: Text("Pedir pizza parado")),
            ElevatedButton(onPressed: (){
              Stream<int> aux = torneira(); 
              aux.listen((int pingo){
                print(pingo);
              });
            }, 
            child: Text("Liguei a torneira")),
            ElevatedButton(onPressed: (){
              controller.sink.add("nnn");

            }, 
            child: Text("Inserir na stream")),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
