import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:malabis_app/data/model/product_model.dart.dart';

class WordPressApi {
  final Dio dio;

  WordPressApi()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://malabis.pk',
          headers: {
            'Authorization': 'Basic ${base64Encode(utf8.encode(
                    'ck_ed96ae2337106d3d2ebdb76c6b2649f276020e59:cs_7e884138b2555a93783d20ca78e7aa78bb4f66f4'))}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

  Future<List<Product>> fetchProducts({int page = 1, int perPage = 10}) async {
    try {
      final response = await dio.get(
        '/wp-json/wc/v3/products',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
