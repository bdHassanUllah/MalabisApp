import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:malabis_app/DTO/model/auth_dto_model.dart';

class CustomerService {
  final Dio dio;

  CustomerService({required this.dio});

  Future<Response> createCustomer(CreateCustomerRequestDto dto) async {
  print('Payload: ${jsonEncode(dto.toJson())}');
  try {
    final response = await dio.post(
      '/wp-json/wc/v3/customers',
      data: dto.toJson(),
    );
    return response;
  } on DioException catch (e) {
    if (e.response?.statusCode == 400) {
      final errorData = e.response?.data;
      print('WooCommerce Error: $errorData');
      if (errorData != null && errorData['code'] == 'registration-error-email-exists') {
        throw Exception('Customer already exists');
      }
    }
    throw Exception('Failed to create customer: ${e.message}');
  }
}

}
