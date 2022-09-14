import 'package:uno/uno.dart';

class UnoService {
  final Uno uno;

  const UnoService(this.uno);

  Future<dynamic> get(String url) async {
    try {
      final response = await uno.get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> post(String url, dynamic data) async {
    try {
      final response = await uno.post(url, data: data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
