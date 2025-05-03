// import 'dart:convert';
// import 'package:dio/dio.dart';

// class ApiClient {
//   static Dio createDioClient({
//     required String baseUrl,
//     required String consumerKey,
//     required String consumerSecret,
//   }) {
//     final credentials = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

//     return Dio(BaseOptions(
//       baseUrl: baseUrl,
//       headers: {
//         'Authorization': 'Basic $credentials',
//         'Content-Type': 'application/json',
//       },
//     ));
//   }
// }
