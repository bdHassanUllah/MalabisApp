import 'dart:convert';
import 'package:dio/dio.dart';

Dio getWooCommerceDioClient({
  required String baseUrl,
  required String consumerKey,
  required String consumerSecret,
}) {
  final String credentials = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/json',
      },
    ),
  );
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
  ));

  return dio;
}
