import 'package:flutter/material.dart';

class PrimeiraTela extends StatelessWidget {
  PrimeiraTela({Key? key}) : super(key: key);
  String nome = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 4.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("https://avatars.githubusercontent.com/u/46936512?v=4", fit: BoxFit.cover),
            ),
          ),
          Text(
            'Gino',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              letterSpacing: 2,
            ),
          ),
          Text('Amigo do Mitsuo', style: TextStyle(
            fontSize: 10, 
            color: Colors.blue,
            letterSpacing: 2),)
        ],
      ),
    );
  }
}
