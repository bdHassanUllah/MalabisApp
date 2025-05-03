
// import 'package:malabis_app/data/model/billing.dart';
// import 'package:malabis_app/data/model/line_item_dto.dart';
// import 'package:malabis_app/data/model/shipping.dart';
// import 'package:malabis_app/data/model/shippingline.dart';

// class CreateOrderRequestDto {
//   final int customerId;
//   final List<LineItemDto> lineItems;
//   final Billing billing;
//   final Shipping shipping;
//   final String paymentMethod;
//   final String paymentMethodTitle;
//   final bool setPaid;
//   final List<ShippingLine> shippingLines;

//   CreateOrderRequestDto({
//     required this.customerId,
//     required this.lineItems,
//     required this.billing,
//     required this.shipping,
//     required this.paymentMethod,
//     required this.paymentMethodTitle,
//     required this.setPaid,
//     required this.shippingLines,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'customer_id': customerId,
//       'line_items': lineItems.map((e) => e.toJson()).toList(),
//       'billing': billing.toJson(),
//       'shipping': shipping.toJson(),
//       'payment_method': paymentMethod,
//       'payment_method_title': paymentMethodTitle,
//       'set_paid': setPaid,
//       'shipping_lines': shippingLines.map((e) => e.toJson()).toList(),
//     };
//   }
// }
