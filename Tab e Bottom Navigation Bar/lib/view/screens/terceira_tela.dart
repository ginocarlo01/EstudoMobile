import 'package:flutter/material.dart';

class TerceiraTela extends StatelessWidget {
  const TerceiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terceira Tela'),
      ),
      body: Container(
        color: Colors.yellow, // Cor de fundo amarelo
        child: const Center(
          child: Text(
            'Bem-vindo à Terceira Tela!',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
