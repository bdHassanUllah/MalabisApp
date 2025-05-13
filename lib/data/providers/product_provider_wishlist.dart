import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';

class ProductProvider {
  final Dio _dio = Dio(); // or inject it

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('https://malabis.pk/wp-json/wc/v3/products/$id',
        options: Options(
          headers: {
            'Authorization': 'Basic ' +
                base64Encode(utf8.encode(
                    'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59:cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4')),
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
