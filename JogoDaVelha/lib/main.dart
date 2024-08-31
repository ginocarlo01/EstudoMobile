import 'package:flutter/material.dart';

import 'model/jogo_da_velha.dart';
import 'view/celula.dart';

void main() {
  runApp(MaterialApp(
    home: JogoDaVelhaApp(),
  ));
}

class JogoDaVelhaApp extends StatefulWidget {
  @override
  _JogoDaVelhaAppState createState() => _JogoDaVelhaAppState();
}

class _JogoDaVelhaAppState extends State<JogoDaVelhaApp> {
  JogoDaVelha jogo = JogoDaVelha();

  void _reiniciarJogo() {
    setState(() {
      jogo.reiniciarJogo();
    });
  }

  void _reiniciarPlacar() {
    setState(() {
      jogo.reiniciarPlacar();
    });
  }

  void _atualizarEstado() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Velha')),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Alinha o botão ao final
        children: [
          Text("Vitórias X: ${jogo.vitoriasX} \tVitórias O: ${jogo.vitoriasO}"),
          Expanded(
            child: Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Número de colunas
                ),
                itemCount: 9, // Número total de células
                itemBuilder: (context, index) {
                  return Celula(
                    jogo: jogo,
                    posicao: index,
                    onGameEnd: _atualizarEstado,
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _reiniciarJogo, // Chama a função para reiniciar o jogo
            child: const Text('Reiniciar Jogo'),
          ),
          ElevatedButton(
            onPressed:
                _reiniciarPlacar, // Chama a função para reiniciar o placar
            child: const Text('Reiniciar Placar'),
          ),
        ],
      ),
    );
  }
}
