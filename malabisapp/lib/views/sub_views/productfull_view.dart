import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/cart_model.dart';
import 'package:malabis_app/data/model/product_model.dart.dart'; //Ensure this is the correct path for CartItem
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/cart/cart_state.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    //final price = double.tryParse(product['price'].toString()) ?? 0;
    final images = product['images'] ?? '';
    final productId = int.tryParse(product['id'].toString()) ?? 0;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: const Color(0xFFC58900),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    //backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  BlocBuilder<WishlistCubit, List<int>>(
                    builder: (context, wishlist) {
                      final isInWishlist = wishlist.contains(productId);
                      return GestureDetector(
                        onTap: () {
                          if (isInWishlist) {
                            context.read<WishlistCubit>().removeFromWishlist(productId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Removed from wishlist')),
                            );
                          } else {
                            context.read<WishlistCubit>().addToWishlist(productId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to wishlist')),
                            );
                          }
                        },
                        child: CircleAvatar(
                          //backgroundColor: Colors.white,
                          child: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: isInWishlist ? Colors.red : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: product['images'] != null &&
                      product['images'] is List &&
                      product['images'].isNotEmpty &&
                      product['images'][0]['src'] != null
                  ? Image.network(
                      images[0]['src'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.broken_image, size: 60)),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  : const Center(child: Icon(Icons.image_not_supported, size: 60)),
            ),
            const SizedBox(height: 16),
            Text(
              product['name'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rs. ${product['price']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('• ${product['uom'] ?? ''}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          // Update the CartCubit state as well
                          context.read<CartCubit>().decreaseQuantity(productId);
                        },
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartItem = state.cartItems.firstWhere(
                            (item) => productId == productId,
                            orElse: () => CartModel(
                              id: productId, 
                              quantity: 1, 
                              name: '', 
                              price: 0,
                              discountedPrice: 0.0, 
                              total: "0.0", 
                              images: []
                            )
                          );
                          return Text(
                            cartItem.quantity.toString(),
                            style: const TextStyle(fontSize: 18)
                          );
                        },
                      ),
                      //Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Update the CartCubit state as well
                          context.read<CartCubit>().increaseQuantity(productId);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final productModel = Product.fromJson(widget.product);
                      final isInCart = state.cartItems.any((item) => item.id == productModel.id);

                      return ElevatedButton(
                        onPressed: () {
                          if (isInCart) {
                            context.read<CartCubit>().removeFromCart(productModel.id);
                          } else {
                            context.read<CartCubit>().addToCart(productModel);
                          }
                        },
                        child: Text(isInCart ? "Remove from Cart" : "Add to Cart"),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            buildSection(
              title: 'Description',
              content: 'Agenda - Jaffer Brothers\n\n'
                  'Scratch & Corrosion Free Glass Cleaner, which may also be used on all hard surfaces to have a neat and clean look',
            ),
            buildExpansion('Use'),
            buildExpansion('Direction for Use'),
            buildExpansion('Warnings'),
            buildExpansion('Safety Datasheet'),
            buildExpansion('PSCIR Report'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(content),
        const Divider(height: 24),
      ],
    );
  }

  Widget buildExpansion(String title) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Details coming soon...'),
        )
      ],
    );
  }
}
