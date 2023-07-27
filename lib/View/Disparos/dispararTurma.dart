import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aviso_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AvisosService.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/BotaoDisparo.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/Campo_corpo.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/Campo_titulo.dart';

class DispararTurma extends StatefulWidget {
  const DispararTurma({Key? key}) : super(key: key);

  @override
  State<DispararTurma> createState() => _DispararTurma();
}

class _DispararTurma extends State<DispararTurma> {
  final formKey = GlobalKey<FormState>();
  String? selectedTurmaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disparar para Turma")),
      body: Center(
          child: Container(
        width: 350,
        margin: const EdgeInsets.only(top: 16),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                campoTitulo,
                const SizedBox(height: 10),
                campoCorpo,
                const SizedBox(height: 10),
                const Text("Selecione uma Turma"),
                buildDropdownButton(),
                const SizedBox(height: 10),
                botaoSalvar(context),
              ],
            )),
      )),
    );
  }

  final campoTitulo = CampoTitulo(controle: TextEditingController());
  final campoCorpo = CampoCorpo(controle: TextEditingController());

  Widget botaoSalvar(BuildContext context) {
    return BotaoDisparo(
      context: context,
      salvar: () async {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var aviso = preencherDTO();
          AvisoInterface dao = AvisoService();
          var titulo = campoTitulo.controle.text;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Confirmar Envio?"),
              content: Text('Titulo do Aviso: $titulo'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fechar"),
                ),
                TextButton(
                  onPressed: () {
                    dao.salvar(aviso);
                    Navigator.pop(context);
                    campoTitulo.controle.clear();
                    campoCorpo.controle.clear();
                  },
                  child: const Text("Enviar"),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildDropdownButton() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Turmas').snapshots(),
      builder: (context, snapshot) {
        List<DropdownMenuItem<String>> turmasItens = [];
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          final turmas = snapshot.data?.docs.reversed.toList();
          for (var turma in turmas!) {
            turmasItens.add(
              DropdownMenuItem(
                value: turma.id,
                child: Text(turma['nome']),
              ),
            );
          }
        }
        return DropdownButton<String>(
          items: turmasItens,
          onChanged: (turmaValue) {
            setState(() {
              selectedTurmaId = turmaValue;
            });
            print(turmaValue);
          },
          value: selectedTurmaId,
          isExpanded: false,
        );
      },
    );
  }

  Aviso preencherDTO() {
    return Aviso(
      titulo: campoTitulo.controle.text,
      corpo: campoTitulo.controle.text,
      turmaIds: [selectedTurmaId!],
      paraTodos: false,
    );
  }
}
