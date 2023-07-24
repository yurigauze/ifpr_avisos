import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Professor.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Professor_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/ProfessorService.dart';
import 'package:ifpr_avisos/View/Widgets/DrawerADM.dart';
import 'package:ifpr_avisos/View/Widgets/PainelBotoes.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/BotaoAdc.dart';

class ProfessorLista extends StatefulWidget {
  ProfessorLista({Key? key}) : super(key: key);

  @override
  State<ProfessorLista> createState() => _ProfessorListaState();
}

class _ProfessorListaState extends State<ProfessorLista> {
  ProfessorInterface dao = ProfessorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Professores')),
      drawer: DrawerGlobal().criarDrawer(context),
      floatingActionButton: BotaoAdicionar(
        acao: () => Navigator.pushNamed(context, '/professorForm')
            .then((value) => buscarProfessor()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: criarLista(context),
    );
  }

  Future<List<Professor>> buscarProfessor() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: dao.consultarTodos(),
      builder: (context, AsyncSnapshot<List<Professor>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Professor');
        List<Professor> listaProfessor = lista.data!;
        return ListView.builder(
          itemCount: listaProfessor.length,
          itemBuilder: (context, indice) {
            var professor = listaProfessor[indice];
            return criarItemLista(context, professor);
          },
        );
      },
    );
  }

  Widget criarItemLista(BuildContext context, Professor professor) {
    return ItemLista(
        professor: professor,
        alterar: () {
          Navigator.pushNamed(context, '/professorForm', arguments: professor)
              .then((value) => buscarProfessor());
        },
        detalhes: () {
          print(professor);
        },
        excluir: () async {
          await dao.excluir(professor.id!);
          buscarProfessor();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Professor professor;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.professor,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(professor.nome!),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: alterar,
    );
  }
}
