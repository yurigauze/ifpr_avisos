import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aviso_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AvisosService.dart';
import 'package:ifpr_avisos/View/BotaoAdc.dart';

import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';
import 'package:ifpr_avisos/View/detalhesAvisos.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AvisoInterface dao = AvisoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avisos'),
      ),
      drawer: DrawerGlobal().criarDrawer(context),
      floatingActionButton: BotaoAdicionar(
        texto: "Disparar Aviso",
        acao: () => Navigator.pushNamed(context, '/disparos')
            .then((value) => buscarTurma()),
      ),
      body: Container(
        child: criarLista(context),
      ),
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarDocumentos("GbXLxT8pka1LTSEFelgo",
          "hP7o2DdconYrrGlbJVNF", "pjcHze8AZoOZvaNfh6M3"),
      builder: (context, AsyncSnapshot<List<Aviso>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Avisos');
        List<Aviso> listaAviso = lista.data!;
        return ListView.builder(
          itemCount: listaAviso.length,
          itemBuilder: (context, indice) {
            var aviso = listaAviso[indice];
            return criarItemLista(context, aviso);
          },
        );
      },
    );
  }

  Future<List<Aviso>> buscarTurma() {
    setState(() {});
    return dao.consultarDocumentos(
        "GbXLxT8pka1LTSEFelgo", "hP7o2DdconYrrGlbJVNF", "pjcHze8AZoOZvaNfh6M3");
  }

  Widget criarItemLista(BuildContext context, Aviso aviso) {
    return ItemLista(aviso: aviso);
  }
}

class ItemLista extends StatelessWidget {
  final Aviso aviso;
  final int limiteCaracteres; // Defina aqui o limite desejado de caracteres

  const ItemLista({required this.aviso, this.limiteCaracteres = 200, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textoCorpo = aviso.corpo!;

    if (textoCorpo.length > limiteCaracteres) {
      // Truncando o texto caso exceda o limite
      textoCorpo = textoCorpo.substring(0, limiteCaracteres) + "...";
    }

    return Column(
      children: [
        ListTile(
          title: Text(aviso.titulo!),
          subtitle: Text(textoCorpo),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetalhesAvisoScreen(aviso: aviso)),
            );
          },
        ),
        const Divider(
          color: Colors
              .grey, // Cor da linha de separação (pode ser alterada conforme desejado)
          thickness: 1.0, // Espessura da linha de separação
        ),
      ],
    );
  }
}
