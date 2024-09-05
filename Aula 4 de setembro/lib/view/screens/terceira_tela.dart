import 'package:flutter/material.dart';

class TerceiraTela extends StatefulWidget {
  const TerceiraTela({Key? key}) : super(key: key);

  @override
  State<TerceiraTela> createState() => _TerceiraTelaState();
}

class _TerceiraTelaState extends State<TerceiraTela> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  int _selectedOption = 1;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Associando a chave ao formulário
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Nome Completo'), // Rótulo do campo
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome'; // Mensagem de erro
              }
              return null;
            },
            onSaved: (value) {
              // Ação ao salvar o campo
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'), // Rótulo do campo
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu e-mail'; // Mensagem de erro
              }
              return null;
            },
            onSaved: (value) {
              // Ação ao salvar o campo
            },
          ),
          CheckboxListTile(
            title: Text('Aceito os termos e condições'),
            value: _termsAccepted,
            onChanged: (bool? value) {
              setState(() {
                _termsAccepted = value ?? false;
              });
            },
          ),
          Text("Metodo de contato preferido"),
          Column(
            children: [
              RadioListTile(
                title: Text('Email'),
                value: 0,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text('Telefone'),
                value: 1,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ],
          ),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            hint: Text('Selecione uma categoria'),
            items: ['Dúvida', 'Sugestão', 'Reclamação'].map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
          ),
          SizedBox(height: 15,)
          ,
          ElevatedButton(
      onPressed: () {
      if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aqui você pode processar os dados salvos
      print('Formulário salvo com sucesso!');
      }
      },
      child: Text('Enviar'),
      ),
        ],
      ),
    );
  }
}
