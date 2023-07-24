import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final VoidCallback? salvar;
  final BuildContext context;
  const Botao({required this.salvar, required this.context, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: salvar,
      child: const Text('Salvar'),
    );
  }
}
