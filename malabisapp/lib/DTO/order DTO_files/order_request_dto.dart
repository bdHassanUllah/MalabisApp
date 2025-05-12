class CreateOrderRequestDto {
  final String paymentMethod;
  final String paymentMethodTitle;
  final bool setPaid;
  int customerId;
  final Billing billing;
  final Shipping shipping;
  final List<LineItem> lineItems;
  final List<ShippingLine> shippingLines;

  CreateOrderRequestDto({
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.setPaid,
    required this.billing,
    required this.shipping,
    required this.lineItems,
    required this.shippingLines, 
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "payment_method": paymentMethod,
      "payment_method_title": paymentMethodTitle,
      "set_paid": setPaid,
      "customer_id": customerId,
      "billing": billing.toJson(),
      "shipping": shipping.toJson(),
      "line_items": lineItems.map((item) => item.toJson()).toList(),
      "shipping_lines": shippingLines.map((line) => line.toJson()).toList(),
    };
  }
}

class Billing {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "address_1": address1,
      "address_2": address2,
      "city": city,
      "state": state,
      "postcode": postcode,
      "country": country,
      "email": email,
      "phone": phone,
    };
  }
}

class Shipping {
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;

  Shipping({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "address_1": address1,
      "address_2": address2,
      "city": city,
      "state": state,
      "postcode": postcode,
      "country": country,
    };
  }
}

class LineItem {
  final int productId;
  final int quantity;
  final int? variationId;

  LineItem({
    required this.productId,
    required this.quantity,
    this.variationId, 
  });

  Map<String, dynamic> toJson() {
    final data = {
      "product_id": productId,
      "quantity": quantity,
    };

    if (variationId != null) {
      data["variation_id"] = variationId!;
    }

    return data;
  }
}

class ShippingLine {
  final String methodId;
  final String methodTitle;
  final String total;

  ShippingLine({
    required this.methodId,
    required this.methodTitle,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      "method_id": methodId,
      "method_title": methodTitle,
      "total": total,
    };
  }
}
