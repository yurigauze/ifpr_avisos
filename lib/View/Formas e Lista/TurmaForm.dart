import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';
import 'package:ifpr_avisos/Controles/Classes/Turnos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turma_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/TurmaService.dart';
import 'package:ifpr_avisos/Controles/Services/TurnoSerive.dart';
import 'package:ifpr_avisos/View/Widgets/Botao.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Turno/Campo_nome_turma.dart';

class TurmaForm extends StatefulWidget {
  const TurmaForm({Key? key}) : super(key: key);

  @override
  State<TurmaForm> createState() => _TurmaForm();
}

class _TurmaForm extends State<TurmaForm> {
  final formKey = GlobalKey<FormState>();

  String? selectedTurnoId;
  dynamic id;

  @override
  Widget build(BuildContext context) {
    Future<List<Turno>> turnos = TurnoService().consultarTodos();
    receberTurmaAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Turma")),
      body: Center(
          child: Container(
              width: 350,
              margin: const EdgeInsets.only(top: 16),
              child: FutureBuilder(
                future: turnos,
                builder: (context, AsyncSnapshot<List<Turno>> lista) {
                  if (!lista.hasData || lista.data == null)
                    return const Text("Não há Turnos cadastrados");
                  listaTurnos = lista.data!;
                  return Form(
                      key: formKey,
                      child: Column(children: [
                        campoNome,
                        const SizedBox(height: 10),
                        Text('Selecione um Turno'),
                        buildDropdownButton(),
                        botaoSalvar(context),
                      ]));
                },
              ))),
    );
  }

  final campoNome = CampoNomeTurma(
    controle: TextEditingController(),
    label: "Turma",
  );
  late DropdownButton<Turno> campoOpcoes;
  late List<Turno> listaTurnos;
  late Turno? turnoSelecionado;

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate() && podeSalvar()) {
          var turma = preencherDTO();
          TurmaInterface dao = TurmaService();
          dao.salvar(turma);
          setState(() {});
          Navigator.pop(context);
        }
      },
    );
  }

  void receberTurmaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Turma turma = parametro.settings.arguments as Turma;
      id = turma.id;
      preencherCampos(turma);
    }
  }

  Widget buildDropdownButton() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Turnos').snapshots(),
      builder: (context, snapshot) {
        List<DropdownMenuItem<String>> turnosItens = [];
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          final turnos = snapshot.data?.docs.reversed.toList();
          for (var turno in turnos!) {
            turnosItens.add(
              DropdownMenuItem(
                value: turno.id,
                child: Text(turno['nome']),
              ),
            );
          }
        }
        return DropdownButton<String>(
          items: turnosItens,
          onChanged: (turnoValue) {
            setState(() {
              selectedTurnoId = turnoValue;
            });
            print(turnoValue);
          },
          value: selectedTurnoId,
          isExpanded: false,
        );
      },
    );
  }

  bool podeSalvar() {
    if (selectedTurnoId == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Turno não selecionado"),
            content: const Text("Selecione um turno antes de salvar."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  Turma preencherDTO() {
    return Turma(
      id: id,
      nome: campoNome.controle.text,
      turnoId: selectedTurnoId,
    );
  }

  void preencherCampos(Turma objeto) async {
    campoNome.controle.text = objeto.nome!;
  }
}
