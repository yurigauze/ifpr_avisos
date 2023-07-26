import 'package:flutter/material.dart';

class BotaoAdicionar extends StatelessWidget {
  final VoidCallback acao;
  final String texto;
  const BotaoAdicionar({required this.acao, Key? key, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => acao(),
      tooltip: texto,
      child: const Icon(Icons.add),
    );
  }
}
