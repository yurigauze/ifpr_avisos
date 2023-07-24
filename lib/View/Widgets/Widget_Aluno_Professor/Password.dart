import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoSenha extends StatefulWidget {
  final TextEditingController controle;

  const CampoSenha({required this.controle, Key? key}) : super(key: key);

  @override
  State<CampoSenha> createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
  bool _obscureText = true;
  final qtdeMinimaCaracteres = 8;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controle,
      validator: (valorDigitado) {
        String? msnErro =
            ehVazio(valorDigitado) ?? temMinimoCaracteres(valorDigitado);
        return msnErro;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
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
