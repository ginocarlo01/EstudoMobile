import 'package:aula_28_08/view/screens/primeira_tela.dart';
import 'package:aula_28_08/view/screens/segunda_tela.dart';
import 'package:aula_28_08/view/screens/terceira_tela.dart';
import 'package:flutter/material.dart';

class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyNavigationBar"),
      ),
      body: IndexedStack(
        index: _currentScreen,
        children: [PrimeiraTela(), const SegundaTela(), const TerceiraTela()],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                color: Colors.blue,
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _currentScreen = 0;
                });
                Navigator.pop(context);
              },
              leading: const Icon(Icons.alarm),
              title: const Text("Primeira Tela"),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _currentScreen = 1;
                });
                Navigator.pop(context);
              },
              leading: const Icon(Icons.cake),
              title: const Text("Segunda Tela"),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _currentScreen = 2;
                });
                Navigator.pop(context);
              },
              leading: const Icon(Icons.dangerous),
              title: const Text("Terceira Tela"),
            )
          ],
        ),
      ),
    );
  }
}
