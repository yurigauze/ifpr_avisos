import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aluno_Interface.dart';
import 'package:ifpr_avisos/Controles/Services/AlunoService.dart';
import 'package:ifpr_avisos/View/Widgets/Botao.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_CPF.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_Telefone.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_email.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Campo_nome.dart';
import 'package:ifpr_avisos/View/Widgets/Widget_Aluno_Professor/Password.dart';

class AlunoForm extends StatefulWidget {
  const AlunoForm({Key? key}) : super(key: key);

  @override
  State<AlunoForm> createState() => _AlunoForm();
}

class _AlunoForm extends State<AlunoForm> {
  final formKey = GlobalKey<FormState>();

  dynamic id;
  String? selectedTurmaId;

  @override
  Widget build(BuildContext context) {
    receberAlunoAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro Aluno")),
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
                const SizedBox(height: 10),
                const Text("Selecione uma Turma"),
                buildDropdownButton(),
                const SizedBox(height: 20),
                botaoSalvar(context),
              ],
            )),
      )),
    );
  }

  final campoNome = CampoNome(
    controle: TextEditingController(),
    label: "Aluno",
  );
  final campoEmail = CampoEmail(controle: TextEditingController());
  final campoSenha = CampoSenha(controle: TextEditingController());
  final confirmaSenha = CampoSenha(controle: TextEditingController());
  final campoCPF = CampoCPF(controle: TextEditingController());
  final campoTelefone = CampoTelefone(controle: TextEditingController());

  Widget botaoSalvar(BuildContext context) {
    return Botao(
      context: context,
      salvar: () async {
        var formState = formKey.currentState;
        if (formState != null && formState.validate() && podeSalvar()) {
          var aluno = preencherDTO();
          AlunoInterface dao = AlunoService();
          String? alunoId = await dao.salvar(aluno);
          adicionarAlunoNaTurma(selectedTurmaId!, alunoId!);
          setState(() {});
          Navigator.pop(context);
        }
      },
    );
  }

  void receberAlunoAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Aluno aluno = parametro.settings.arguments as Aluno;
      id = aluno.id;
      preencherCampos(aluno);
    }
  }

  Widget buildDropdownButton() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Turmas').snapshots(),
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
              selectedTurmaId = turnoValue;
            });
            print(turnoValue);
          },
          value: selectedTurmaId,
          isExpanded: false,
        );
      },
    );
  }

  Aluno preencherDTO() {
    return Aluno(
      id: id,
      nome: campoNome.controle.text,
      cpf: campoCPF.controle.text,
      email: campoEmail.controle.text,
      telefone: campoTelefone.controle.text,
      password: campoSenha.controle.text,
    );
  }

  bool podeSalvar() {
    if (selectedTurmaId == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Turma não selecionado"),
            content: const Text("Selecione uma Turma antes de salvar."),
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

// Função para adicionar o ID do aluno à lista de alunos da turma
  void adicionarAlunoNaTurma(String selectedTurmaId, String alunoId) {
    FirebaseFirestore.instance
        .collection('Turmas')
        .doc(selectedTurmaId)
        .update({
      'alunos': FieldValue.arrayUnion([alunoId])
    });
  }

  void preencherCampos(Aluno objeto) async {
    campoNome.controle.text = objeto.nome!;
    campoCPF.controle.text = objeto.cpf!;
    campoEmail.controle.text = objeto.email!;
    campoSenha.controle.text = objeto.password!;
    confirmaSenha.controle.text = objeto.password!;
    campoTelefone.controle.text = objeto.telefone!;
  }
}
