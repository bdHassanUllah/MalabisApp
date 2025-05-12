
import 'package:malabis_app/data/model/product_image.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';

class CartModel {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String total;
  final double discountedPrice;
  final List<ProductImage> images; 

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountedPrice,
    required this.images,
  });

  /// Factory constructor to create a CartModel from a Product
  factory CartModel.fromProduct(Product product, {int quantity = 1}) {
    return CartModel(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: quantity,
      total: (product.price * quantity).toString(),
      discountedPrice: product.discountedPrice,
      images: product.images,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discounted_price': discountedPrice,
      'quantity': quantity,
      'total': total.toString(),
    };
  }

  /// Create from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      discountedPrice: json['discounted_price'].toDouble(),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      images: json['images'] != null
          ? (json['images'] as List)
              .map((image) => ProductImage.fromJson(image))
              .toList()
          : [],
    );
  }

  /// Copy with modified fields
  CartModel copyWith({
    int? id,
    String? name,
    String? model,
    double? price,
    double? discountedPrice,
    int? quantity,
    double? total,
    List<ProductImage>? images,
  }) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      quantity: quantity ?? this.quantity,
      total: total?.toString() ?? this.total,
      images: images ?? this.images,
    );
  }
}
