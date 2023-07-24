import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Turma.dart';

class Turno {
  String? id;
  final String nome;
  final String? descricao;

  Turno({this.id, required this.nome, this.descricao});

  static Turno fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw Exception("DocumentSnapshot data is null!");
    return Turno(
      id: snapshot.id,
      nome: data['nome'],
      descricao: data['descricao'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nome != null) "nome": nome,
      if (descricao != null) "descricao": descricao,
    };
  }
}
