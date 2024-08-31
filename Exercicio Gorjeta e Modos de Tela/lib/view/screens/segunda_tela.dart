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
    return Center(
      child: Column(
        children: [
          TextFormField(
            initialValue: alou.amount,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                alou.amount = value;
              });
            },
            decoration: const InputDecoration(labelText: 'Valor Total'),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
            ],
          ),
          InputDecorator(
              decoration:
                  const InputDecoration(labelText: 'Gorjeta,Customizada'),
              child: Slider(
                min: 1, max: 50, value: double.parse(alou.customTip).toDouble(),
                onChanged: (double? value) {
                  setState(() {
                    alou.customTip = (value)!.toStringAsFixed(2);
                  });
                },
                // Outros parâmetros.
              )),
          Text(alou.defaultTip),
          Text(alou.customTippedAmount),
          Text(alou.amountPlusDefaultTippedAmount),
          Text(alou.amountPlusCustomTippedAmount)
        ],
      ),
    );
  }
}
