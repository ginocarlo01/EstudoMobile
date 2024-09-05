import 'package:aula_28_08/view/screens/primeira_tela.dart';
import 'package:aula_28_08/view/screens/segunda_tela.dart';
import 'package:aula_28_08/view/screens/terceira_tela.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyBottomNavigationBar")),
      body: IndexedStack(
        children: [PrimeiraTela(), const SegundaTela(), const TerceiraTela()],
        index: _currentScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (value) {
          setState(() {
            _currentScreen = value;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.wifi), label: "adsf"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.face_2), label: "adsf"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.hail_outlined), label: "adsf")
        ],
        fixedColor: Colors.red,
      ),
    );
  }
}
