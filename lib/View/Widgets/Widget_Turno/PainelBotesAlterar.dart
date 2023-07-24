import 'package:flutter/material.dart';

class PainelEditar extends StatelessWidget {
  final VoidCallback alterar;
  const PainelEditar({required this.alterar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(
            onPressed: alterar,
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
