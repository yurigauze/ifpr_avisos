import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aluno_Interface.dart';

class AlunoService implements AlunoInterface {
  CollectionReference alunoCollection =
      FirebaseFirestore.instance.collection('Alunos');

  @override
  Future<List<Aluno>> consultarTodos() async {
    final querySnapshot = await alunoCollection.get();

    final alunos = querySnapshot.docs
        .map((doc) => Aluno.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return alunos;
  }

  @override
  Future<List<Aluno>> consultarPorTurma(String idTurma) async {
    CollectionReference turmaCollection =
        FirebaseFirestore.instance.collection('Turmas');
    final docSnapshot = await turmaCollection.doc(idTurma).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final listaAlunos = data['alunos'] as List<dynamic>;
      final List<String> listaIdsAlunos = listaAlunos.cast<String>();

      final querySnapshot = await alunoCollection
          .where(FieldPath.documentId, whereIn: listaIdsAlunos)
          .get();

      final alunos = querySnapshot.docs
          .map((doc) => Aluno.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>, null))
          .toList();
      return alunos;
    } else {
      return []; // Retorna uma lista vazia se o documento de turma não existir
    }
  }

  @override
  Future<void> excluir(String id) async {
    final docRef = alunoCollection.doc(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      await docRef.delete();
    } else {
      throw AlunoNaoEncontradoException(
          "O aluno com ID '$id' não foi encontrado.");
    }
  }

  @override
  Future<String?> salvar(Aluno aluno) async {
    if (aluno.id != null) {
      await alunoCollection.doc(aluno.id!).set(
        {
          'nome': aluno.nome,
          'cpf': aluno.cpf,
          'email': aluno.email,
          'password': aluno.password,
          'telefone': aluno.telefone,
          'token': aluno.token,
        },
        SetOptions(
            merge:
                true), // Usa merge para atualizar apenas os campos modificados
      );
    } else {
      // Se o ID do aluno for nulo, cria um novo aluno com ID automático gerado pelo Firestore
      final newDocRef = await alunoCollection.add(
        {
          'nome': aluno.nome,
          'cpf': aluno.cpf,
          'email': aluno.email,
          'password': aluno.password,
          'telefone': aluno.telefone,
          'token': aluno.token,
        },
      );
      // Atualiza o ID do aluno com o ID gerado pelo Firestore
      aluno.id = newDocRef.id;
    }
    return aluno.id;
  }

  @override
  Future<Aluno> consultar(String id) async {
    final ref = alunoCollection.doc(id).withConverter(
          fromFirestore: Aluno.fromFirestore,
          toFirestore: (Aluno aluno, _) => aluno.toFirestore(),
        );
    final docSnap = await ref.get();
    final aluno = docSnap.data(); //Converte para objeto Aluno
    if (aluno != null) {
      return aluno;
    }
    throw AlunoNaoEncontradoException("ID do aluno não encontrado: $id");
  }

  static AlunoNaoEncontradoException(String mensagem) {
    return AlunoNaoEncontradoException("Aluno não encontrado: $mensagem");
  }
}
