import 'package:campus/controles/dto/aluno.dart';
import 'package:campus/controles/dto/aviso.dart';
import 'package:campus/controles/interface/aluno_dao_interface.dart';
import 'package:campus/controles/interface/aviso_dao_interface.dart';
import 'package:campus/controles/sqlite/dao/aluno_dao_sqlite.dart';
import 'package:campus/controles/sqlite/dao/aviso_dao_sqlite.dart';
import 'package:flutter/material.dart';

class DispararAlunosProfessor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disparar para Alunos',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Disparar para Alunos'),
        ),
        body: DispararAlunosProf(),
      ),
    );
  }
}

class DispararAlunosProf extends StatefulWidget {
  @override
  _DispararTurmaProfessorState createState() => _DispararTurmaProfessorState();
}

class _DispararTurmaProfessorState extends State<DispararAlunosProf> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _Titulo = TextEditingController();
  TextEditingController _Texto = TextEditingController();
  AvisoDao dao = AvisoDAOSQLite();
  String? _selectedItem;
  Aluno? alunoSelecionado;
  dynamic id;
  List<Aluno> alunos = [];

  @override
  void initState() {
    super.initState();
    alunoSelecionado = alunos.isNotEmpty ? alunos[0] : null;
    buscarAlunos();
  }

  Future<void> buscarAlunos() async {
    AlunoDao alunoDAO = AlunoDAOSQLite();
    List<Aluno> listaAlunos = await alunoDAO.consultarTodos();
    setState(() {
      alunos = listaAlunos;
    });
  }

  @override
  void dispose() {
    _Titulo.dispose();
    _Texto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 390,
        margin: EdgeInsets.only(top: 16),
        child: Column(children: [
          Row(children: [
            Text('Selecione o Aluno(a):'),
            DropdownButton<Aluno>(
              value: alunoSelecionado,
              onChanged: (Aluno? novoAluno) {
                setState(() {
                  alunoSelecionado = novoAluno;
                  _selectedItem = novoAluno?.nome;
                });
              },
              items: alunos.map((Aluno aluno) {
                return DropdownMenuItem<Aluno>(
                  value: aluno,
                  child: Text(aluno.nome),
                );
              }).toList(),
            ),
          ]),
          SizedBox(
            width: 50,
            height: 10, // Espaço desejado
          ),
          TextField(
            controller: _Titulo,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              hintText: 'Titulo do Aviso',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(fontSize: 18),
            maxLength: 50,
          ),
          SizedBox(
            width: 50,
            height: 10, // Espaço desejado
          ),
          Card(
              color: const Color.fromARGB(255, 235, 235, 235),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _Texto,
                  maxLines: 8, //or null
                  maxLength: 500,
                  decoration:
                      InputDecoration.collapsed(hintText: "Qual o aviso?"),
                ),
              )),
          ElevatedButton(
            onPressed: () {
              var titulo = _Titulo.text;
              var texto = _Texto.text;

              if (alunoSelecionado == null || titulo == null || texto == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("Campos em branco."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {

                int? idTurma = alunoSelecionado?.id;
                var aviso = preencherDTO();
                AvisoDao dao = AvisoDAOSQLite();
                dao.salvarAvisoAluno(aviso, idTurma ?? 0);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("Enviado para a aluno(a): $_selectedItem"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Fechar"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
              height: 40,
              width: 70,
              child: Row(
                children: [
                  Text('Enviar'),
                  Text(' '),
                  Icon(Icons.send, size: 24),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Aviso preencherDTO() {
    return Aviso(
      id: id,
      titulo: _Titulo.text,
      corpo: _Texto.text,
    );
  }
}
