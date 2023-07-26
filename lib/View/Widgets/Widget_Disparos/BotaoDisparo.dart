import 'package:flutter/material.dart';

class BotaoDisparo extends StatelessWidget {
  final VoidCallback? salvar;
  final BuildContext context;
  const BotaoDisparo({required this.salvar, required this.context, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: salvar,
        child: const SizedBox(
          width: 75,
          child: Row(
            children: [
              Icon(Icons.send),
              SizedBox(width: 10),
              Text('Enviar'),
            ],
          ),
        ));
  }
}
