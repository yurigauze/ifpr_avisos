import 'package:ifpr_avisos/Controles/Classes/Alunos.dart';

abstract class AlunoInterface {
  Future<String?> salvar(Aluno aluno);
  Future<void> excluir(String id);
  Future<Aluno> consultar(String id);
  Future<List<Aluno>> consultarTodos();
  Future<List<Aluno>> consultarPorTurma(String id);
}
