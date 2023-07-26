import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Turnos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turno_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/TurnoSerive.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Turno/PainelBotesAlterar.dart';
import 'package:ifpr_avisos/View/Widgets/PainelBotoes.dart';

class TurnosLista extends StatefulWidget {
  TurnosLista({Key? key}) : super(key: key);

  @override
  State<TurnosLista> createState() => _TurnosListaState();
}

class _TurnosListaState extends State<TurnosLista> {
  TurnoInterface dao = TurnoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turnos')),
      drawer: DrawerGlobal().criarDrawer(context),
      body: criarLista(context),
    );
  }

  Future<List<Turno>> buscarTurno() {
    setState(() {});
    return dao.consultarTodos();
  }

  @override
  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Turno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turno');
        List<Turno> listaTurnos = lista.data!;
        return ListView.builder(
          itemCount: listaTurnos.length,
          itemBuilder: (context, indice) {
            var turno = listaTurnos[indice];
            return criarItemLista(context, turno);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Turno turno) {
    return ItemLista(
      turno: turno,
      alterar: () {
        Navigator.pushNamed(context, '/turnoForm', arguments: turno)
            .then((value) => buscarTurno());
      },
      detalhes: () {
        print(turno);
      },
    );
  }
}

class ItemLista extends StatelessWidget {
  final Turno turno;
  final VoidCallback alterar;
  final VoidCallback detalhes;

  const ItemLista(
      {required this.turno,
      required this.alterar,
      required this.detalhes,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(turno.nome!),
      subtitle: Text(turno.descricao!),
      trailing: PainelEditar(alterar: alterar),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/turmasPorTurno', // Rota para a nova tela
          arguments: turno.id, // Passando o id do turno como argumento
        );
      },
    );
  }
}
