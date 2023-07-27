import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetalhesAvisoScreen extends StatelessWidget {
  final Aviso aviso;

  DetalhesAvisoScreen({super.key, required this.aviso});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Aviso'),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: conteudo(context),
              ),
              abaixo(context),
              const SizedBox(height: 10),
            ],
          )
        ]));
  }

  Widget conteudo(BuildContext context) {
    const int maxCharactersPerLine =
        35; // Defina o número máximo de caracteres por linha

    String textoCorpo = aviso.corpo!;

    // Adiciona quebras de linha a cada N caracteres
    String textoComQuebrasDeLinha = '';

    int currentIndex = 0;
    while (currentIndex < textoCorpo.length) {
      int nextIndex = currentIndex + maxCharactersPerLine;
      if (nextIndex > textoCorpo.length) {
        nextIndex = textoCorpo.length;
      }
      textoComQuebrasDeLinha +=
          textoCorpo.substring(currentIndex, nextIndex) + '\n';
      currentIndex = nextIndex;
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350, // Defina o tamanho do Container conforme necessário
            // Defina o tamanho do Container conforme necessário
            padding: const EdgeInsets.all(20.0),
            child: AutoSizeText(
              aviso.titulo!,
              style: const TextStyle(
                  fontSize:
                      25), // Defina o tamanho da fonte conforme necessário
              textAlign: TextAlign.center,
              maxLines:
                  10, // Defina o número máximo de linhas que você deseja exibir
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 370, // Defina o tamanho do Container conforme necessário
            // Defina o tamanho do Container conforme necessário
            padding: const EdgeInsets.all(20.0),
            child: AutoSizeText(
              aviso.corpo!,
              style: const TextStyle(
                  fontSize:
                      16), // Defina o tamanho da fonte conforme necessário
              textAlign: TextAlign.left,
              maxLines:
                  20, // Defina o número máximo de linhas que você deseja exibir
            ),
          )
        ],
      ),
    );
  }

  Widget abaixo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(aviso.id!,
        style: const TextStyle(color: Color.fromARGB(255, 105, 105, 105)));
  }
}
