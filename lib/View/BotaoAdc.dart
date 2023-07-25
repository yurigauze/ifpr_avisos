import 'package:flutter/material.dart';

class BotaoAdicionar extends StatelessWidget {
  final VoidCallback acao;
  const BotaoAdicionar({required this.acao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.add),
      onSelected: (int value) {
        // Ação a ser executada quando uma opção é selecionada
        if (value == 1) {
          acao();
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar'),
          ),
        ),
        // Você pode adicionar mais opções aqui, se necessário
      ],
    );
  }
}
