import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aviso_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AvisosService.dart';
import 'package:ifpr_avisos/View/BotaoAdc.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';

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
        title: const Text('Início'),
      ),
      drawer: DrawerGlobal().criarDrawer(context),
      floatingActionButton: BotaoAdicionar(
        acao: () => Navigator.pushNamed(context, '/turmaForm')
            .then((value) => buscarTurma()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        child: criarLista(context),
      ),
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarDocumentos(null, null, null),
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
    return dao.consultarDocumentos(null, null, null);
  }

  Widget criarItemLista(BuildContext context, Aviso aviso) {
    return ItemLista(aviso: aviso);
  }
}

class ItemLista extends StatelessWidget {
  final Aviso aviso;

  const ItemLista({required this.aviso, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(aviso.titulo!), subtitle: Text(aviso.corpo!), onTap: () {});
  }
}
