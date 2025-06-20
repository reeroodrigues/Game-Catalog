import 'package:dio/dio.dart';

Dio createDioClient() {
  final options = BaseOptions(
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  final dio = Dio(options);
  dio.interceptors.add(LogInterceptor(responseBody: true));
  return dio;
}
