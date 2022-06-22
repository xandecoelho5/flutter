import 'package:coincap/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _baseUrl = _appConfig!.coinApiBaseUrl;
  }

  Future<Map<String, dynamic>?> get(String path) async {
    try {
      final response = await dio.get('$_baseUrl$path');
      return response.data;
    } catch (e) {
      print('HttpService: Unable to perform get request. $e');
      return null;
    }
  }
}
