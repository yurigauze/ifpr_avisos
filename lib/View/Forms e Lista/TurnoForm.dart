import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Turnos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turno_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/TurnoSerive.dart';
import 'package:ifpr_avisos/View/Widgets/Botao.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Turno/Campo_Desc.dart';

class TurnoForm extends StatefulWidget {
  const TurnoForm({Key? key}) : super(key: key);

  @override
  State<TurnoForm> createState() => _TurnoForm();
}

class _TurnoForm extends State<TurnoForm> {
  final formKey = GlobalKey<FormState>();

  dynamic id;
  String? nome;

  @override
  Widget build(BuildContext context) {
    receberTurnoAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: Text("Alterar Turno $nome")),
      body: Center(
          child: Container(
        width: 370,
        margin: EdgeInsets.only(top: 12),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                campoNome,
                campoDesc,
                const SizedBox(height: 20),
                botaoSalvar(context),
              ],
            )),
      )),
    );
  }

  final campoDesc = CampoDescricao(
    controle: TextEditingController(),
    label: 'Descrição',
  );
  final campoNome = CampoDescricao(
    controle: TextEditingController(),
    enabled: false,
    label: 'Nome do Turno',
  );

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var turno = preencherDTO();
          TurnoInterface dao = TurnoService();
          dao.salvar(turno);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberTurnoAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Turno turno = parametro.settings.arguments as Turno;
      id = turno.id;
      nome = turno.nome;
      preencherCampos(turno);
    }
  }

  Turno preencherDTO() {
    return Turno(
      id: id,
      nome: campoNome.controle.text,
      descricao: campoDesc.controle.text,
    );
  }

  void preencherCampos(Turno objeto) async {
    campoDesc.controle.text = objeto.descricao!;
    campoNome.controle.text = objeto.nome!;
  }
}
