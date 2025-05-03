// lib/data/repositories/home_repository.dart
import 'package:malabis_app/apifiles/api.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';

class HomeRepository {
  final WordPressApi api;

  HomeRepository({required this.api});

  Future<List<Product>> getProducts({int page = 1}) async {
  try {
    return await api.fetchProducts(page: page); // Adjust your API method
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
}

}
