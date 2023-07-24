import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turma_Interface.dart';

class TurmaService implements TurmaInterface {
  CollectionReference turmaCollection =
      FirebaseFirestore.instance.collection('Turmas');

  @override
  Future<List<Turma>> consultarTodos() async {
    final querySnapshot = await turmaCollection.get();

    final turmas = querySnapshot.docs
        .map((doc) => Turma.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return turmas;
  }

  @override
  Future<List<Turma>> consultarPorTurno(String id) async {
    final querySnapshot =
        await turmaCollection.where("turnoId", isEqualTo: id).get();

    final turmas = querySnapshot.docs
        .map((doc) => Turma.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return turmas;
  }

  @override
  Future<void> excluir(String id) async {
    final docRef = turmaCollection.doc(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      await docRef.delete();
    } else {
      throw TurmaNaoEncontradoException(
          "A turma com ID '$id' não foi encontrado.");
    }
  }

  @override
  Future<void> salvar(Turma turma) async {
    if (turma.id != null) {
      await turmaCollection.doc(turma.id!).set(
        {
          'nome': turma.nome,
          'turnoId': turma.turnoId,
        },
        SetOptions(
            merge:
                true), // Usa merge para atualizar apenas os campos modificados
      );
    } else {
      // Se o ID do aluno for nulo, cria um novo aluno com ID automático gerado pelo Firestore
      final newDocRef = await turmaCollection.add(
        {
          'nome': turma.nome,
          'turnoId': turma.turnoId,
        },
      );
      // Atualiza o ID do aluno com o ID gerado pelo Firestore
      turma.id = newDocRef.id;
    }
  }

  @override
  Future<Turma> consultar(String id) async {
    final ref = turmaCollection.doc(id).withConverter(
          fromFirestore: Turma.fromFirestore,
          toFirestore: (Turma turma, _) => turma.toFirestore(),
        );
    final docSnap = await ref.get();
    final turma = docSnap.data(); //Converte para objeto Aluno
    if (turma != null) {
      return turma;
    }
    throw TurmaNaoEncontradoException("ID da turma não encontrado: $id");
  }

  static TurmaNaoEncontradoException(String mensagem) {
    return TurmaNaoEncontradoException("Turma não encontrada: $mensagem");
  }
}
