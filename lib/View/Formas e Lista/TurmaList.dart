import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turma_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/TurmaService.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';
import 'package:ifpr_avisos/View/Widgets/PainelBotoes.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/BotaoAdc.dart';

class TurmaLista extends StatefulWidget {
  TurmaLista({Key? key}) : super(key: key);

  @override
  State<TurmaLista> createState() => _TurmaListaState();
}

class _TurmaListaState extends State<TurmaLista> {
  TurmaInterface dao = TurmaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Turmas')),
      drawer: DrawerGlobal().criarDrawer(context),
      floatingActionButton: BotaoAdicionar(
        acao: () => Navigator.pushNamed(context, '/turmaForm')
            .then((value) => buscarTurma()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: criarLista(context),
    );
  }

  Future<List<Turma>> buscarTurma() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
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
    return ItemLista(
        turma: turma,
        alterar: () {
          Navigator.pushNamed(context, '/turmaForm', arguments: turma)
              .then((value) => buscarTurma());
        },
        detalhes: () {
          print(turma);
        },
        excluir: () async {
          await dao.excluir(turma.id!);
          buscarTurma();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Turma turma;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.turma,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(turma.nome!),
        trailing: PainelBotoes(alterar: alterar, excluir: excluir),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/alunosPorTurma', // Rota para a nova tela
            arguments: turma.id, // Passando o id do turno como argumento
          );
        });
  }
}
