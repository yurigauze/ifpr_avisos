import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Turnos.dart';
import 'package:ifpr_avisos/Controles/Interfaces/Turno_Interface.dart';

class TurnoService implements TurnoInterface {
  CollectionReference turnoCollection =
      FirebaseFirestore.instance.collection('Turnos');

  @override
  Future<List<Turno>> consultarTodos() async {
    final querySnapshot = await turnoCollection.get();

    final turnos = querySnapshot.docs
        .map((doc) => Turno.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>, null))
        .toList();
    return turnos;
  }

  @override
  Future<void> excluir(String id) async {
    final docRef = turnoCollection.doc(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      await docRef.delete();
    } else {
      throw TurnoNaoEncontradoException(
          "O turno com ID '$id' não foi encontrado.");
    }
  }

  @override
  Future<void> salvar(Turno turno) async {
    if (turno.id != null) {
      await turnoCollection.doc(turno.id!).set(
        {
          'descricao': turno.descricao,
        },
        SetOptions(
            merge:
                true), // Usa merge para atualizar apenas os campos modificados
      );
    } else {
      // Se o ID do turno for nulo, cria um novo turno com ID automático gerado pelo Firestore
      final newDocRef = await turnoCollection.add(
        {
          'nome': turno.nome,
          'descricao': turno.descricao,
        },
      );
      // Atualiza o ID do turno com o ID gerado pelo Firestore
      turno.id = newDocRef.id;
    }
  }

  @override
  Future<Turno> consultar(String id) async {
    final ref = turnoCollection.doc(id).withConverter(
          fromFirestore: Turno.fromFirestore,
          toFirestore: (Turno turno, _) => turno.toFirestore(),
        );
    final docSnap = await ref.get();
    final turno = docSnap.data(); //Converte para objeto Turno
    if (turno != null) {
      return turno;
    }
    throw TurnoNaoEncontradoException("ID do turno não encontrado: $id");
  }

  static TurnoNaoEncontradoException(String mensagem) {
    return TurnoNaoEncontradoException("Turno não encontrado: $mensagem");
  }
}
