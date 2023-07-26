import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aluno_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AlunoService.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';

class AlunoPorTurma extends StatefulWidget {
  const AlunoPorTurma({Key? key}) : super(key: key);
  @override
  State<AlunoPorTurma> createState() => _AlunoPorTurma();
}

class _AlunoPorTurma extends State<AlunoPorTurma> {
  AlunoInterface dao = AlunoService();
  final formKey = GlobalKey<FormState>();
  late String turmaId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperando o argumento passado para a rota e atribuindo à variável turnoId
    turmaId = ModalRoute.of(context)?.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Alunos')),
      drawer: DrawerGlobal().criarDrawer(context),
      body: criarLista(context),
    );
  }

  Future<List<Aluno>> buscarALuno() {
    setState(() {});
    return dao.consultarPorTurma(turmaId);
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarPorTurma(turmaId),
      builder: (context, AsyncSnapshot<List<Aluno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Alunos');
        List<Aluno> listaTurma = lista.data!;
        return ListView.builder(
          itemCount: listaTurma.length,
          itemBuilder: (context, indice) {
            var aluno = listaTurma[indice];
            return criarItemLista(context, aluno);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Aluno aluno) {
    return ItemLista(aluno: aluno);
  }
}

class ItemLista extends StatelessWidget {
  final Aluno aluno;

  const ItemLista({required this.aluno, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(aluno.nome!),
    );
  }
}
