import 'package:dio/dio.dart';

const DB_URL = 'https://jsonbox.io/box_7ea9df49e805cf99509b';

Dio craeteDio() {
  BaseOptions options = BaseOptions(
    baseUrl: DB_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Dio dio = Dio(options);

  dio.interceptors.add(LogInterceptor(
    error: true,
    request: false,
    responseBody: true,
    responseHeader: false,
    requestHeader: false,
  ));

  return dio;
}
