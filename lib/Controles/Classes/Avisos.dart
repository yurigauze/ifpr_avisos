import 'package:cloud_firestore/cloud_firestore.dart';

class Aviso {
  String? id;
  final String? titulo;
  final String? corpo;
  final List<String>? ids;
  final bool? paraTodos;

  Aviso({this.id, this.titulo, this.corpo, this.ids, this.paraTodos});

  static Aviso fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw Exception("DocumentSnapshot data is null!");
    return Aviso(
      id: snapshot.id,
      titulo: data['titulo'],
      corpo: data['corpo'],
      ids: data['ids'],
      paraTodos: data['todos'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo": titulo,
      if (corpo != null) "corpo": corpo,
      'todos': paraTodos,
      "ids": ids,
    };
  }
}
