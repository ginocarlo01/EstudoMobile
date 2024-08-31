import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/jogo_da_velha.dart';

class Celula extends StatefulWidget {
  final JogoDaVelha jogo;
  final int posicao;
  final VoidCallback onGameEnd;

  Celula({required this.jogo, required this.posicao, required this.onGameEnd});

  @override
  State<Celula> createState() => _CelulaState();
}

class _CelulaState extends State<Celula> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _fazerJogada,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: _buildContent(),
      ),
    );
  }

  _buildContent() {
    String text = '';

    int estado = widget.jogo.obterEstadoPosicao(widget.posicao);
    if (estado == 1) {
      text = 'X';
    } else if (estado == -1) {
      text = 'O';
    }

    return Text(text, style: const TextStyle(fontSize: 48));
  }

  _fazerJogada() {
    if (widget.jogo.vencedor == 0 && widget.jogo.jogar(widget.posicao)) {
      setState(() {});

      widget.jogo.vencedor = widget.jogo.checkVictory();

      if (widget.jogo.vencedor != 0) {
        String victoryTitle = 'Vitória';
        String player = '';

        if (widget.jogo.vencedor == 1) {
          player = 'X';
          widget.jogo.vitoriasX++;
        } else if (widget.jogo.vencedor == -1) {
          player = 'O';
          widget.jogo.vitoriasO++;
        }
        setState(() {});

        String victoryMessage = "Vitória do jogador: '$player'!";
        widget.onGameEnd();
        _showMyDialog(victoryTitle, victoryMessage);
      } else if (widget.jogo.checkDraw()) {
        String drawTitle = 'Empate';
        String drawMessage =
            'A partida terminou em empate, reinicie para tentar novamente!';
        widget.onGameEnd();
        _showMyDialog(drawTitle, drawMessage);
      }
    }
  }

  Future<void> _showMyDialog(title, message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
