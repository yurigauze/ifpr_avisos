import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Aviso_Interface.dart';

class AvisoService implements AvisoInterface {
  CollectionReference avisoCollection =
      FirebaseFirestore.instance.collection('Avisos');

  @override
  Future<List<Aviso>> consultarTodos() async {
    final querySnapshot =
        await avisoCollection.where("ids", isEqualTo: Null).get();

    final avisos = querySnapshot.docs
        .map((doc) => Aviso.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return avisos;
  }

  @override
  Future<List<Aviso>> consultarDocumentos(
    String? turnoId,
    String? turmaId,
    String? alunoId,
  ) async {
    CollectionReference avisoCollection =
        FirebaseFirestore.instance.collection('Avisos');

    // Comece com uma consulta vazia (sem documentos)

    // Verifique se o turnoId não é nulo e adicione o filtro à consulta
    List<Aviso> avisos = [];

    // Consulta usando apenas o filtro de turnoId
    if (turnoId != null) {
      QuerySnapshot querySnapshotTurno =
          await avisoCollection.where("turnoIds", arrayContains: turnoId).get();
      avisos.addAll(querySnapshotTurno.docs.map((doc) => Aviso.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null)));
    }

    // Consulta usando apenas o filtro de turmaId
    if (turmaId != null) {
      QuerySnapshot querySnapshotTurma =
          await avisoCollection.where("turmaIds", arrayContains: turmaId).get();
      avisos.addAll(querySnapshotTurma.docs.map((doc) => Aviso.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null)));
    }

    // Consulta usando apenas o filtro de alunoId
    if (alunoId != null) {
      QuerySnapshot querySnapshotAluno =
          await avisoCollection.where("alunoIds", arrayContains: alunoId).get();
      avisos.addAll(querySnapshotAluno.docs.map((doc) => Aviso.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null)));
    }

    // consulta quando é para todos
    if (alunoId != null && turmaId != null && turnoId != null) {
      QuerySnapshot querySnapshotAluno =
          await avisoCollection.where("todos", isEqualTo: true).get();
      avisos.addAll(querySnapshotAluno.docs.map((doc) => Aviso.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>, null)));
    }

    return avisos;
  }

  @override
  Future<void> excluir(String id) async {
    final docRef = avisoCollection.doc(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      await docRef.delete();
    } else {
      throw AvisoNaoEncontradoException(
          "O aviso com ID '$id' não foi encontrado.");
    }
  }

  @override
  Future<String?> salvar(Aviso aviso) async {
    if (aviso.id != null) {
      await avisoCollection.doc(aviso.id!).set(
        {
          'titulo': aviso.titulo,
          'corpo': aviso.corpo,
          if (aviso.paraTodos != null) "todos": aviso.paraTodos,
          if (aviso.turnoIds != null) "turnoIds": aviso.turnoIds,
          if (aviso.turmaIds != null) "turmaIds": aviso.turmaIds,
          if (aviso.alunoIds != null) "alunoIds": aviso.alunoIds,
        },
        SetOptions(
            merge:
                true), // Usa merge para atualizar apenas os campos modificados
      );
    } else {
      // Se o ID do aluno for nulo, cria um novo aluno com ID automático gerado pelo Firestore
      final newDocRef = await avisoCollection.add(
        {
          'titulo': aviso.titulo,
          'corpo': aviso.corpo,
          if (aviso.paraTodos != null) "todos": aviso.paraTodos,
          if (aviso.turnoIds != null) "turnoIds": aviso.turnoIds,
          if (aviso.turmaIds != null) "turmaIds": aviso.turmaIds,
          if (aviso.alunoIds != null) "alunoIds": aviso.alunoIds,
        },
      );
      // Atualiza o ID do aluno com o ID gerado pelo Firestore
      aviso.id = newDocRef.id;
    }
    return aviso.id;
  }

  @override
  Future<Aviso> consultar(String id) async {
    final ref = avisoCollection.doc(id).withConverter(
          fromFirestore: Aviso.fromFirestore,
          toFirestore: (Aviso aviso, _) => aviso.toFirestore(),
        );
    final docSnap = await ref.get();
    final aviso = docSnap.data(); //Converte para objeto aviso
    if (aviso != null) {
      return aviso;
    }
    throw AvisoNaoEncontradoException("ID do Aviso não encontrado: $id");
  }

  static AvisoNaoEncontradoException(String mensagem) {
    return AvisoNaoEncontradoException("Aviso não encontrado: $mensagem");
  }
}
