import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Professor.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Professor_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/ProfessorService.dart';
import 'package:ifpr_avisos/View/Widgets/Botao.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_CPF.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_Telefone.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_email.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_nome.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Password.dart';

class ProfessorForm extends StatefulWidget {
  const ProfessorForm({Key? key}) : super(key: key);

  @override
  State<ProfessorForm> createState() => _ProfessorForm();
}

class _ProfessorForm extends State<ProfessorForm> {
  final formKey = GlobalKey<FormState>();

  dynamic id;

  @override
  Widget build(BuildContext context) {
    receberProfessorAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Professor")),
      body: Center(
          child: Container(
        width: 350,
        margin: EdgeInsets.only(top: 16),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                campoNome,
                campoCPF,
                campoEmail,
                campoTelefone,
                campoSenha,
                confirmaSenha,
                const SizedBox(height: 20),
                botaoSalvar(context),
              ],
            )),
      )),
    );
  }

  final campoNome = CampoNome(
    controle: TextEditingController(),
    label: "Professor",
  );
  final campoEmail = CampoEmail(controle: TextEditingController());
  final campoSenha = CampoSenha(controle: TextEditingController());
  final confirmaSenha = CampoSenha(controle: TextEditingController());
  final campoCPF = CampoCPF(controle: TextEditingController());
  final campoTelefone = CampoTelefone(controle: TextEditingController());

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var professor = preencherDTO();
          ProfessorInterface dao = ProfessorService();
          dao.salvar(professor);
          setState(() {});
          Navigator.pop(context);
        }
      },
    );
  }

  void receberProfessorAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Professor professor = parametro.settings.arguments as Professor;
      id = professor.id;
      preencherCampos(professor);
    }
  }

  Professor preencherDTO() {
    return Professor(
      id: id,
      nome: campoNome.controle.text,
      cpf: campoCPF.controle.text,
      email: campoEmail.controle.text,
      telefone: campoTelefone.controle.text,
      password: campoSenha.controle.text,
    );
  }

  void preencherCampos(Professor objeto) async {
    campoNome.controle.text = objeto.nome!;
    campoCPF.controle.text = objeto.cpf!;
    campoEmail.controle.text = objeto.email!;
    campoSenha.controle.text = objeto.password!;
    confirmaSenha.controle.text = objeto.password!;
    campoTelefone.controle.text = objeto.telefone!;
  }
}
