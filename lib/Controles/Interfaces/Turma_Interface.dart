import 'package:ifpr_avisos/Controles/Classes/Turma.dart';

abstract class TurmaInterface {
  salvar(Turma turma);
  Future<void> excluir(String id);
  Future<Turma> consultar(String id);
  Future<List<Turma>> consultarTodos();
  Future<List<Turma>> consultarPorTurno(String id);
}
