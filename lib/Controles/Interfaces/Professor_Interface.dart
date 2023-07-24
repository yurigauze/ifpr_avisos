import 'package:ifpr_avisos/Controles/Classes/Professor.dart';

abstract class ProfessorInterface {
  salvar(Professor professor);
  Future<void> excluir(String id);
  Future<Professor> consultar(String id);
  Future<List<Professor>> consultarTodos();
}
