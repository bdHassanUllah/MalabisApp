import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/data/providers/product_provider_wishlist.dart';

class ProductRepository {
  final ProductProvider _provider = ProductProvider();

  Future<Product> fetchProductById(int id) => _provider.getProductById(id);
}
