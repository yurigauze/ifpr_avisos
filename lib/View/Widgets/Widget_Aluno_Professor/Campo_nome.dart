import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoNome extends StatelessWidget {
  final qtdeMinimaCaracteres = 3;
  final mascara = '[A-Za-z\u00C0-\u00FF ]';
  final TextEditingController controle;
  final String label;
  const CampoNome({required this.controle, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.name,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(mascara))],
      validator: (valorDigitado) {
        String? msnErro =
            ehVazio(valorDigitado) ?? temMinimoCaracteres(valorDigitado);
        return msnErro;
      },
      decoration: InputDecoration(
          label: Text(label), hintText: 'Informe o nome do $label'),
    );
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
