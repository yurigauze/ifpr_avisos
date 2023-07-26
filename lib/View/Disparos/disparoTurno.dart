import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aviso_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AvisosService.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/BotaoDisparo.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/Campo_corpo.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Disparos/Campo_titulo.dart';

class DispararTurno extends StatefulWidget {
  const DispararTurno({Key? key}) : super(key: key);

  @override
  State<DispararTurno> createState() => _DispararTurno();
}

class _DispararTurno extends State<DispararTurno> {
  final formKey = GlobalKey<FormState>();
  String? selectedTurnoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disparar para Turno")),
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
                const Text("Selecione um Turno"),
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

  Aviso preencherDTO() {
    return Aviso(
      titulo: campoTitulo.controle.text,
      corpo: campoTitulo.controle.text,
      turnoIds: [selectedTurnoId!],
    );
  }
}
