import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<CartCubit>().state.cartItems;

    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E323D),
        elevation: 0,
        title: const Text("My Cart", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: false,
      ),
      body: cartItems.isEmpty
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Oops! Your cart is empty.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Looks like you haven’t added anything yet.\nStart shopping now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          )

          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final item = cartItems[index];
                      final imageUrl = item.images.isNotEmpty
                          ? item.images.first.src
                          : 'https://via.placeholder.com/150';

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.amber, size: 24),
                            const SizedBox(width: 8),
                            Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, // Border color
                                    width: 1,           // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(8), // Match ClipRRect radius
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "Rs. ${(item.price ?? item.price) * item.quantity}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(width: 70),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .decreaseQuantity(item.id);
                                        },
                                      ),
                                      Text(item.quantity.toString()), // Convert quantity to String
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .increaseQuantity(item.id);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            /*IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .removeFromCart(item.product_id);
                              },
                            ),*/
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final cartItems = context.read<CartCubit>().state.cartItems;
                        Navigator.pushNamed(
                          context,
                          invoicescreen,
                          arguments: cartItems, // 👈 Pass the correct list
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}