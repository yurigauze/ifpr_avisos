import 'package:cloud_firestore/cloud_firestore.dart';

class Aviso {
  String? id;
  final String? titulo;
  final String? corpo;
  final List<String>? turnoIds;
  final List<String>? turmaIds;
  final List<String>? alunoIds;
  final bool? paraTodos;

  Aviso(
      {this.id,
      this.titulo,
      this.corpo,
      this.turnoIds,
      this.turmaIds,
      this.alunoIds,
      this.paraTodos});

  static Aviso fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw Exception("DocumentSnapshot data is null!");
    return Aviso(
      id: snapshot.id,
      titulo: data['titulo'],
      corpo: data['corpo'],
      turnoIds: data['turnoIds'],
      turmaIds: data['turmaIds'],
      alunoIds: data['alunoIds'],
      paraTodos: data['todos'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo": titulo,
      if (corpo != null) "corpo": corpo,
      'todos': paraTodos,
      "turnoIds": turnoIds,
      "turmaIds": turnoIds,
      "alunoIds": turnoIds,
    };
  }
}
