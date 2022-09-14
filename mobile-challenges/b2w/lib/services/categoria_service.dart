import 'package:b2w/models/categoria.dart';
import 'package:b2w/services/uno_service.dart';

class CategoriaService {
  final UnoService unoService;

  const CategoriaService(this.unoService);

  Future<List<Categoria>> findAll() async {
    final response = await unoService.get('/categoria');
    final categorias = response['data'] as List;
    return categorias.map((c) => Categoria.fromMap(c)).toList();
  }
}
