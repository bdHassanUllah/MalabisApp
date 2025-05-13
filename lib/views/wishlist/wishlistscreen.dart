import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/data/repository/product_wishlist_repository.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/views/bottom_navbar.dart';
import 'package:malabis_app/views/home/home_page.dart'; // Where ProductCard is defined

class WishlistScreen extends StatelessWidget {
  WishlistScreen({super.key});

  // ✅ Create a repository instance
  final ProductRepository _repository = ProductRepository();

  // ✅ Method to fetch product by ID
  Future<Product> fetchProductById(int productId) async {
    return await _repository.fetchProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wishlist',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
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
              child: Text(
                'No products in the wishlist',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
              ),
            );
          }

          final limitedWishlist = wishlist.take(20).toList();

          return ListView.builder(
            itemCount: limitedWishlist.length,
            itemBuilder: (context, index) {
              final productId = limitedWishlist[index];

              return SizedBox(
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
}
