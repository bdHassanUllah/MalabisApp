class ProductImage {
  final String src;

  ProductImage({required this.src});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      src: json['src'] ?? 'https://via.placeholder.com/150',
    );
  }

  Map<String, dynamic> toJson() => {
    'src': src,
  };
}
