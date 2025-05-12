import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:malabis_app/DTO/model/auth_dto_model.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  Future<Response> createCustomer(CreateCustomerRequestDto customerDTO) async {
    try {
      final response = await dio.post(
        '/wp-json/wc/v3/customers',
        data: customerDTO.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to create customer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating customer: $e');
    }
  }

  static Dio createDioClient({
    required String baseUrl,
    required String consumerKey,
    required String consumerSecret,
  }) {
    final String credentials = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
