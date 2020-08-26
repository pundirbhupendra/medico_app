import 'package:dio/dio.dart';

class ApiService {
  ApiService._internal() {
    dio = Dio();
    dio.options
      ..baseUrl = ''
      ..contentType = '';
  }
  Dio dio;

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }
}
