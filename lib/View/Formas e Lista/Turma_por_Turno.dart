import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turma_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/TurmaService.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';

class TurmasPorTurno extends StatefulWidget {
  const TurmasPorTurno({Key? key}) : super(key: key);
  @override
  State<TurmasPorTurno> createState() => _TurmasPorTurno();
}

class _TurmasPorTurno extends State<TurmasPorTurno> {
  TurmaInterface dao = TurmaService();
  final formKey = GlobalKey<FormState>();
  late String turnoId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperando o argumento passado para a rota e atribuindo à variável turnoId
    turnoId = ModalRoute.of(context)?.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Turmas')),
      drawer: DrawerGlobal().criarDrawer(context),
      body: criarLista(context),
    );
  }

  Future<List<Turma>> buscarTurma() {
    setState(() {});
    return dao.consultarPorTurno(turnoId);
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarPorTurno(turnoId),
      builder: (context, AsyncSnapshot<List<Turma>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Turmas');
        List<Turma> listaTurma = lista.data!;
        return ListView.builder(
          itemCount: listaTurma.length,
          itemBuilder: (context, indice) {
            var turma = listaTurma[indice];
            return criarItemLista(context, turma);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Turma turma) {
    return ItemLista(turma: turma);
  }
}

class ItemLista extends StatelessWidget {
  final Turma turma;

  const ItemLista({required this.turma, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(turma.nome!),
    );
  }
}
