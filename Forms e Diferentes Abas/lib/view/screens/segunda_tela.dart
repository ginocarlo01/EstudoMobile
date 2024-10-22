import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Control/tip.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({Key? key}) : super(key: key);

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  final Tip alou = Tip.withData(customTip: 15, totalAmount: 100);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade100,
            Colors.blue.shade900,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/114208654?v=4",
                ),
              ),
            ),
            Text(
              'Mitsuo',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            Text(
              'Amigo do Gino',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, color: Colors.white),
                SizedBox(width: 20),
                Icon(Icons.link, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
