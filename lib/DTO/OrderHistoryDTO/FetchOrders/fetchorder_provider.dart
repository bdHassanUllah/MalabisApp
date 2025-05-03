import 'dart:convert';
import 'package:dio/dio.dart';

class OrderFetchProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://malabis.pk/wp-json/wc/v3',
      headers: {
        'Authorization': 'Basic ${base64Encode(
          utf8.encode(
            'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59:cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4',
          ),
        )}',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>?> getOrderById(int orderId) async {
    try {
      final response = await _dio.get('/orders/$orderId');
      return response.data;
    } catch (e) {
      print('Error fetching order by ID: $e');
      return null;
    }
  }


  Future<int?> getWooCustomerIdByEmail(String email) async {
    try {
      final response = await _dio.get(
        '/customers',
        queryParameters: {'email': email},
      );
      final data = response.data;
      if (data is List && data.isNotEmpty) {
        return data[0]['id']; // WooCommerce customer ID
      } else {
        print('No WooCommerce customer found for email: $email');
        return null;
      }
    } catch (e) {
      print('Error fetching WooCommerce ID: $e');
      return null;
    }
  }

  Future<List<dynamic>> getOrdersByCustomerId(int customerId) async {
    try {
      final response = await _dio.get(
        '/orders',
        queryParameters: {
          'customer': customerId,
          'per_page': 20,
        },
      );
      return response.data;
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }
}
