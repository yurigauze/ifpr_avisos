import 'package:ifpr_avisos/Controles/Classes/Turnos.dart';

abstract class TurnoInterface {
  salvar(Turno aluno);
  Future<void> excluir(String id);
  Future<Turno> consultar(String id);
  Future<List<Turno>> consultarTodos();
}
