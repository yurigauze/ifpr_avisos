import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Aluno {
  String? id;
  final String? nome;
  final String? cpf;
  final String? email;
  final String? password;
  final String? telefone;
  final String? token;

  Aluno(
      {this.id,
      this.nome,
      this.cpf,
      this.email,
      this.password,
      this.telefone,
      this.token});

  static Aluno fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) throw Exception("DocumentSnapshot data is null!");
    return Aluno(
      id: snapshot.id,
      nome: data['nome'],
      cpf: data['cpf'],
      email: data['email'],
      password: data['password'],
      telefone: data['telefone'],
      token: data['token'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nome != null) "nome": nome,
      if (cpf != null) "cpf": cpf,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (telefone != null) "telefone": telefone,
    };
  }
}
