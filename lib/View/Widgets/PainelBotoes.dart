import 'package:flutter/material.dart';
import 'package:ifpr_avisos/color_schemes.g.dart';

class PainelBotoes extends StatelessWidget {
  final VoidCallback alterar;
  final VoidCallback excluir;
  const PainelBotoes({required this.alterar, required this.excluir, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(
            onPressed: excluir,
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: alterar,
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
