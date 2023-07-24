import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';

class Turma {
  String? id;
  final List<String>? professor;
  final String? nome;
  final String? turnoId; // Identificador do turno ao qual a turma pertence
  final List<String>? alunos;

  Turma({this.id, this.professor, this.nome, this.turnoId, this.alunos});

  // Adicione um construtor para criar a partir do Map
  static Turma fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw Exception("DocumentSnapshot data is null!");
    return Turma(
      id: snapshot.id,
      nome: data['nome'],
      turnoId: data['turnoId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (nome != null) "nome": nome,
      if (professor != null) "professor": professor,
      if (turnoId != null) "turnoId": turnoId,
    };
  }
}
