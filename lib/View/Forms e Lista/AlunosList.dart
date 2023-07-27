import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aluno_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AlunoService.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';
import 'package:ifpr_avisos/View/Widgets/PainelBotoes.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/BotaoAdc.dart';

class AlunosLista extends StatefulWidget {
  AlunosLista({Key? key}) : super(key: key);

  @override
  State<AlunosLista> createState() => _AlunosListaState();
}

class _AlunosListaState extends State<AlunosLista> {
  AlunoInterface dao = AlunoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Alunos')),
      drawer: DrawerGlobal().criarDrawer(context),
      floatingActionButton: BotaoAdicionar(
        texto: 'Adicionar',
        acao: () => Navigator.pushNamed(context, '/alunoForm')
            .then((value) => buscarAluno()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: criarLista(context),
    );
  }

  Future<List<Aluno>> buscarAluno() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Aluno>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há alunos');
        List<Aluno> listaAlunos = lista.data!;
        return ListView.builder(
          itemCount: listaAlunos.length,
          itemBuilder: (context, indice) {
            var aluno = listaAlunos[indice];
            return criarItemLista(context, aluno);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Aluno aluno) {
    return ItemLista(
        aluno: aluno,
        alterar: () {
          Navigator.pushNamed(context, '/alunoForm', arguments: aluno)
              .then((value) => buscarAluno());
        },
        detalhes: () {
          print(aluno);
        },
        excluir: () async {
          String alunonome = aluno.nome!;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirmar Exclusão?"),
              content: Text('Turma a ser excluida: \n$alunonome'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fechar"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await dao.excluir(aluno.id!);
                    buscarAluno();
                  },
                  child: const Text("Excluir"),
                ),
              ],
            ),
          );
        });
  }
}

class ItemLista extends StatelessWidget {
  final Aluno aluno;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.aluno,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(aluno.nome!),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: alterar,
    );
  }
}
