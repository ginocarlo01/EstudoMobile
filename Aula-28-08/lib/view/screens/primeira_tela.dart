import 'package:flutter/material.dart';

class PrimeiraTela extends StatelessWidget {
  PrimeiraTela({Key? key}) : super(key: key);
  String nome = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Nome")),
                onSaved: (String? newValue) {
                  nome = newValue ?? "";
                },
                validator: (String? value) {
                  if (value != null) {
                    if (value.length < 3) {
                      return "Erro: nao existe nome de tres letras";
                    }
                  } else {
                    return "Erro: Insira seu nome";
                  }
                },
              ),
              TextFormField(),
              TextFormField(
                validator: (String? value) {
                  if (value == null) {
                    return "Erro";
                  } else {
                    if (value.length < 10) {
                      return "Erro";
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //so vai entrar nesse validate se for tudo valido
                        _formKey.currentState!.save();
                      }
                    },
                    child: Text("Submit")),
              )
            ],
          )),
    );
  }
}
