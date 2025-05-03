import 'dart:convert';
import 'package:dio/dio.dart';

class OrderPlaceProvider {
  final Dio dio;

  OrderPlaceProvider()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://malabis.pk/wp-json/wc/v3/',
            headers: {
              'Authorization': 'Basic ${base64Encode(utf8.encode('ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59:cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4'))}',
              'Content-Type': 'application/json',
            },
          ),
        );

  Future<Response> placeOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await dio.post(
        'orders',
        data: orderData,
      );
      return response;
    } catch (e) {
      throw Exception("Failed to place order: $e");
    }
  }

  Future<List<dynamic>> getOrdersByCustomerId(int customerId) async {
    try {
      final response = await dio.get(
        'orders',
        queryParameters: {
          'customer': customerId,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }
}
