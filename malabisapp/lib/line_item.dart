class LineItem {
  final int productId;
  final int quantity;

  LineItem({required this.productId, required this.quantity});

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
