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
    List<String>? turmaIds = data['turmaIds'] != null
        ? (data['turmaIds'] as List<dynamic>).cast<String>()
        : null;
    List<String>? alunoIds = data['alunoIds'] != null
        ? (data['alunoIds'] as List<dynamic>).cast<String>()
        : null;
    List<String>? turnoIds = data['turnoIds'] != null
        ? (data['turnoIds'] as List<dynamic>).cast<String>()
        : null;
    return Aviso(
      id: snapshot.id,
      titulo: data['titulo'],
      corpo: data['corpo'],
      turnoIds: turnoIds,
      turmaIds: turmaIds,
      alunoIds: alunoIds,
      paraTodos: data['todos'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo": titulo,
      if (corpo != null) "corpo": corpo,
      if (paraTodos != null) 'todos': paraTodos,
      if (turnoIds != null) "turnoIds": turnoIds,
      if (turnoIds != null) "turmaIds": turnoIds,
      if (turnoIds != null) "alunoIds": turnoIds,
    };
  }
}
