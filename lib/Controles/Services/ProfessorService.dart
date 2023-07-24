import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Professor.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Professor_Interface.dart';

class ProfessorService implements ProfessorInterface {
  CollectionReference professorCollection =
      FirebaseFirestore.instance.collection('Professor');

  @override
  Future<List<Professor>> consultarTodos() async {
    final querySnapshot = await professorCollection.get();

    final professores = querySnapshot.docs
        .map((doc) => Professor.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return professores;
  }

  @override
  Future<void> excluir(String id) async {
    final docRef = professorCollection.doc(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      await docRef.delete();
    } else {
      throw ProfessorNaoEncontradoException(
          "O professor com ID '$id' não foi encontrado.");
    }
  }

  @override
  Future<void> salvar(Professor professor) async {
    if (professor.id != null) {
      await professorCollection.doc(professor.id!).set(
        {
          'nome': professor.nome,
          'cpf': professor.cpf,
          'email': professor.email,
          'password': professor.password,
          'telefone': professor.telefone,
          'token': professor.token,
        },
        SetOptions(
            merge:
                true), // Usa merge para atualizar apenas os campos modificados
      );
    } else {
      // Se o ID do aluno for nulo, cria um novo aluno com ID automático gerado pelo Firestore
      final newDocRef = await professorCollection.add(
        {
          'nome': professor.nome,
          'cpf': professor.cpf,
          'email': professor.email,
          'password': professor.password,
          'telefone': professor.telefone,
          'token': professor.token,
        },
      );
      // Atualiza o ID do aluno com o ID gerado pelo Firestore
      professor.id = newDocRef.id;
    }
  }

  @override
  Future<Professor> consultar(String id) async {
    final ref = professorCollection.doc(id).withConverter(
          fromFirestore: Professor.fromFirestore,
          toFirestore: (Professor professor, _) => professor.toFirestore(),
        );
    final docSnap = await ref.get();
    final professor = docSnap.data(); //Converte para objeto Aluno
    if (professor != null) {
      return professor;
    }
    throw ProfessorNaoEncontradoException(
        "ID do professor não encontrado: $id");
  }

  static ProfessorNaoEncontradoException(String mensagem) {
    return ProfessorNaoEncontradoException(
        "professor não encontrado: $mensagem");
  }
}
