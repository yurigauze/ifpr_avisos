import 'package:flutter/material.dart';

class CampoCorpo extends StatelessWidget {
  final qtdeMinimaCaracteres = 3;
  final TextEditingController controle;
  const CampoCorpo({required this.controle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controle,
        maxLines: 8, //or null
        maxLength: 500,
        decoration: const InputDecoration.collapsed(hintText: "Qual o aviso?"),
        validator: (valorDigitado) {
          String? msnErro =
              ehVazio(valorDigitado) ?? temMinimoCaracteres(valorDigitado);
          return msnErro;
        },
      ),
    ));
  }

  String? ehVazio(String? valorDigitado) {
    if (valorDigitado == null || valorDigitado.isEmpty)
      return 'O campo é obrigatório';
    return null;
  }

  String? temMinimoCaracteres(String? valorDigitado) {
    if (valorDigitado!.length < qtdeMinimaCaracteres)
      return 'O campo deve possuir pelo menos 3 caracteres';
    return null;
  }
}
