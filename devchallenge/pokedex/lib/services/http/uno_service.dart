import 'package:pokedex/services/http/i_http_service.dart';
import 'package:uno/uno.dart';

class UnoService implements IHttpService {
  final Uno uno;

  UnoService(this.uno);

  @override
  Future<dynamic> get(String url) async {
    final response = await uno.get(url);
    return response.data;
  }
}
