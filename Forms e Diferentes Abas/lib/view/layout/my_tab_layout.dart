import 'package:aula_28_08/view/screens/primeira_tela.dart';
import 'package:aula_28_08/view/screens/segunda_tela.dart';
import 'package:aula_28_08/view/screens/terceira_tela.dart';
import 'package:flutter/material.dart';

class MyTabLayout extends StatelessWidget {
  const MyTabLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text("MyTabLayout"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.wifi), text: "Wifi"),
                Tab(icon: Icon(Icons.face), text: "Carinha"),
                Tab(icon: Icon(Icons.hail_outlined), text: "Carona"),
              ],
            ),
          ),
          body: TabBarView(
            children: [PrimeiraTela(), SegundaTela(), TerceiraTela()],
          )),
    );
  }
}
