import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



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
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
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
    );
  }
}
