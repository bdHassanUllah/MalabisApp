import 'package:malabis_app/data/model/category_model.dart';
import 'package:malabis_app/data/model/product_image.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final double discountedPrice;
  final String stockStatus;
  final List<Category> categories;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.stockStatus,
    required this.categories,
    required this.images, 
    required String description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    price: double.tryParse(json['price'].toString()) ?? 0, // ✅
    discountedPrice: double.tryParse(json['discountedPrice'].toString()) ?? 0.0, // ✅
    stockStatus: json['stock_status'] ?? '',
    categories: (json['categories'] ?? [])
        .map<Category>((c) => Category.fromJson(c))
        .toList(),
    images: (json['images'] ?? [])
        .map<ProductImage>((i) => ProductImage.fromJson(i))
        .toList(),
    description: json['description'] ?? '', // Assuming you have a description field in your JSON
  );


  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'discounted_price': discountedPrice,
        'stock_status': stockStatus,
        //'categories': categories.map((c) => c.toJson()).toList(),
        'images': images.map((i) => i.toJson()).toList(),
      };
}
