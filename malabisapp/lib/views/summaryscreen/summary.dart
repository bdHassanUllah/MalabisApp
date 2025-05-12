import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart' as dto;
import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart';
import 'package:malabis_app/data/model/cart_model.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/logic/order/orders_state.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

class SummaryScreen extends StatefulWidget {
  final List<CartModel> cartItems;
  const SummaryScreen({super.key, required this.cartItems});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  double _calculateSubtotal(List<CartModel> items) {
  return items.fold(0.0, (sum, item) {
    final priceToUse = item.discountedPrice ?? item.price;
    print("Discounted price = $priceToUse");
    print("Sum price = $sum");
    print("Quantity price = ${item.quantity}");
    return sum + priceToUse * item.quantity;
  });
}


  @override
  void initState() {
    super.initState();
    print("Received Cart Items: ${widget.cartItems.length}");
  }


  Future<void> _placeOrder(List<CartModel> cartItems, double deliveryFee, int customerId) async {
    final shipping = Shipping(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      country: countryController.text.trim(),
      city: cityController.text.trim(),
      postcode: postalCodeController.text.trim(),
      address1: "Default Address Line 1",
      address2: "Default Address Line 2",
      state: "Default State",
    );

    final billing = dto.Billing(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      address1: "Default Billing Address Line 1",
      address2: "Default Billing Address Line 2",
      city: cityController.text.trim(),
      state: "Default State",
      postcode: postalCodeController.text.trim(),
      country: countryController.text.trim(),
      email: emailController.text.trim(),
      phone: "Default Phone Number",
    );

    final orderRequest = dto.CreateOrderRequestDto(
      customerId: customerId, // Replace with actual customer ID
      paymentMethod: 'cod', // Example: Cash on Delivery
      paymentMethodTitle: 'Cash on Delivery', // Example: Title for payment method
      setPaid: false, // Example: Payment not set as paid
      billing: billing, // Use the billing object created earlier
      shipping: shipping, // Use the shipping object created earlier
      shippingLines: [
        dto.ShippingLine(
          methodId: 'flat_rate',
          methodTitle: 'Flat Rate',
          total: deliveryFee.toString(),
        ),
      ],
      lineItems: cartItems.map((item) => dto.LineItem(
        productId: item.id, 
        quantity: item.quantity,
        //price: item.price
      )).toList(), // Add cart items to the order
    );

    context.read<OrdersPlaceCubit>().placeOrder(orderRequest, customerId);

  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.cartItems;  // Use the passed cartItems
    final subtotal = _calculateSubtotal(cartItems);
    const deliveryFee = 400.0;
    final total = subtotal + deliveryFee;
    //final authState = context.read<AuthCubit>().state;
    

    return BlocListener<OrdersPlaceCubit, OrderPlaceState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          context.read<CartCubit>().clearCart();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Order placed successfully!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, orderscreen);
          });
        } else if (state is OrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Summary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFC58900),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //...cartItems.map((item) => _buildCartItemRow(item)),
                  //const SizedBox(height: 16),
                  //_buildSummaryCard(subtotal, deliveryFee, total),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Contact Information"),
                  const Text("We'll use this email to send you details and updates about your order.",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  _buildTextField("Email Address", controller: emailController, validator: _validateEmail),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Shipping Address"),
                  const Text("Enter the address where you want your order delivered.",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  _buildTextField("First Name", controller: firstNameController),
                  _buildTextField("Last Name", controller: lastNameController),
                  _buildTextField("Country/Region", controller: countryController),
                  _buildTextField("City", controller: cityController),
                  _buildTextField("Phone Number", controller: phoneNumberController, keyboardType: TextInputType.number, validator: _validatePhoneNumber),
                  _buildTextField("Postal Code", controller: postalCodeController, keyboardType: TextInputType.number, validator: _validatePostalCode),
                  const SizedBox(height: 20),
                  BlocBuilder<OrdersPlaceCubit, OrderPlaceState>(
                    builder: (context, state) {
                      final isLoading = state is OrderLoading;
                      return Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                          ),
                          onPressed: isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  final authState = context.read<AuthCubit>().state;
                                    if (authState is AuthAuthenticated) {
                                      await _placeOrder(cartItems, deliveryFee, authState.userId!);
                                    } 
                                    else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("You must be logged in to place an order.")),
                                      );
                                    }
                                  }
                                  Navigator.pushReplacementNamed(context, thanku);
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Place Order", style: TextStyle(color: Colors.black)),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }

  Widget _buildCartItemRow(CartModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text("${item.name} x${item.quantity}")),
          Text("Rs. ${((item.price) * item.quantity).toStringAsFixed(0)}"),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(double subtotal, double deliveryFee, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Subtotal", "Rs. ${subtotal.toStringAsFixed(0)}"),
          _buildSummaryRow("Delivery", "Rs. $deliveryFee", subText: "Flat Rate"),
          const Divider(),
          _buildSummaryRow("Total", "Rs. ${total.toStringAsFixed(0)}", bold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {String? subText, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
            if (subText != null) Text(subText, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          Text(amount, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildTextField(
    String hint, {
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator ?? _validateRequired,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validatePostalCode(String? value) {
    if (value == null || value.isEmpty) return 'Postal code is required';
    if (value.length != 5 || int.tryParse(value) == null) return 'Enter a valid 5-digit postal code';
    return null;
  }

String? _validatePhoneNumber(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Phone number is required';
  }
  if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) {
    return 'Enter a valid phone number';
  }
  return null; // Valid input
}



  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }
}