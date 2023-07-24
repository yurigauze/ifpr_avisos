import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: use_key_in_widget_constructors
class CampoCPF extends StatelessWidget {
  final mascara = '###.###.###-##';
  final TextEditingController controle;
  const CampoCPF({required this.controle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.phone,
      inputFormatters: [MaskTextInputFormatter(mask: mascara)],
      validator: (valorDigitado) => ehVazio(valorDigitado),
      decoration: const InputDecoration(
          label: Text('CPF:'), hintText: '999.999.999-99'),
    );
  }

  String? ehVazio(String? valorDigitado) {
    if (valorDigitado == null || valorDigitado.isEmpty)
      return 'O campo é obrigatório';
    return null;
  }
}
