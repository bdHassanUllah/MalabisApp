import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/views/bottom_navbar.dart';
import 'package:malabis_app/views/home/home_page.dart'; // If ProductCard is here

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Wishlist', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white, size: 30),
            tooltip: 'Clear Wishlist',
            onPressed: () {
              context.read<WishlistCubit>().clearWishlist();
            },
          ),
        ],
        backgroundColor: const Color(0xFFC58900),
      ),
      body: BlocBuilder<WishlistCubit, List<int>>(
        builder: (context, wishlist) {
          if (wishlist.isEmpty) {
            return const Center(
              child: Text('No products in the wishlist',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
              ),
            );
          }

          // Limit the number of products shown at once for testing
          final limitedWishlist = wishlist.take(20).toList(); // Show only the first 20

          return ListView.builder(
            itemCount: limitedWishlist.length,
            itemBuilder: (context, index) {
              final productId = limitedWishlist[index];

              return SizedBox( // ✅ Ensures layout safety
                height: 160,
                child: FutureBuilder<Product>(
                  future: fetchProductById(productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text('Error loading product'));
                    }

                    return ProductCard(product: snapshot.data!);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Future<Product> fetchProductById(int productId) async {
    // Replace this with actual product fetching logic
    return Product(
      id: productId,
      name: "Sample Product",
      price: 100,
      discountedPrice: 90.0,
      images: [],
      stockStatus: 'In Stock',
      description: 'Sample description',
      categories: [],
    );
  }
}
