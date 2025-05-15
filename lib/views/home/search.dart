import 'package:malabis_app/data/model/product_model.dart.dart';

class ProductSearchHelper {
  final Map<int, Product> _productMap = {}; // HashMap for fast lookup

  ProductSearchHelper(List<Product> products) {
    for (var product in products) {
      _productMap[product.id] = product;
    }
  }

  // Method to search by product name
  List<Product> searchByName(String query) {
    if (query.isEmpty) return _productMap.values.toList();

    final lowerQuery = query.toLowerCase();
    return _productMap.values.where((product) {
      return product.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
