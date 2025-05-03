
import 'package:malabis_app/line_item.dart';

class OrderModel {
  final int id; // WooCommerce sends this as int
  final String status;
  final String total;
  final List<LineItem> lineItems;

  OrderModel({
    required this.id,
    required this.status,
    required this.total,
    required this.lineItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? 'pending',
      total: json['total'] ?? "0.0",
      lineItems: (json['line_items'] as List<dynamic>?)
              ?.map((e) => LineItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total': total,
      'line_items': lineItems.map((e) => e.toJson()).toList(),
    };
  }
}
