import 'package:ifpr_avisos/Controles/Classes/Avisos.dart';

abstract class AvisoInterface {
  Future<String?> salvar(Aviso aviso);
  Future<void> excluir(String id);
  Future<Aviso> consultar(String id);
  Future<List<Aviso>> consultarTodos();
  Future<List<Aviso>> consultarDocumentos(
      String? turnoId, String? turmaId, String? alunoId);
}
