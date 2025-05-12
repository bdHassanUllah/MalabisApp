import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/cart/cart_state.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/home/home_state.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Only if HomeCubit is not initialized elsewhere
    // context.read<HomeCubit>().loadInitialProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeCubit>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC58900), // Set AppBar color to C58900
        title: Padding(
          padding: const EdgeInsets.fromLTRB(
            0,
            20,
            0,
            30,
          ), // Adjust for better position
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Search products...',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            style: const TextStyle(color: Colors.black),
            onChanged: (query) {
              // Search logic
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, cartscreen);
            },
          ),
        ],
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          if (state is HomeLoaded) {
            final products = state.products;
            return ListView(
              controller: _scrollController,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add SizedBox here
                    const SizedBox(height: 16),
                    // Carousel
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount: products.take(3).length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Image.network(
                            product.images.isNotEmpty
                                ? product.images.first.src
                                : '',
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Center(
                                  child: Icon(Icons.broken_image),
                                ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    // Categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Browse Categories',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to categories screen
                              Navigator.pushNamed(context, '/categoryscreen');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _CategoryCircle(
                            name: 'Adhesive',
                            image: 'lib/assets/images/category.png',
                          ),
                          _CategoryCircle(
                            name: 'All Purpose Cleaner',
                            image: 'lib/assets/images/category.png',
                          ),
                          _CategoryCircle(
                            name: 'Backpacks',
                            image: 'lib/assets/images/category.png',
                          ),
                          _CategoryCircle(
                            name: 'Bakery',
                            image: 'lib/assets/images/category.png',
                          ),
                          _CategoryCircle(
                            name: 'Baking',
                            image: 'lib/assets/images/category.png',
                          ),
                        ],
                      ),
                    ),
                    // Recommended
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended for You!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to recommended products screen
                              Navigator.pushNamed(context, '/recommended');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder:
                            (context, index) =>
                                ProductCard(product: products[index]),
                      ),
                    ),
                    // Trending
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending Products!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to trending products screen
                              Navigator.pushNamed(context, '/trending');
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder:
                            (context, index) =>
                                ProductCard(product: products[index]),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ],
            );
          }
          return const Center(child: Text('No products available'));
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.pushNamed(
            context,
            detailscreen,
            arguments: product.toJson(),
          );
        },
        child: Stack(
          children: [
            SizedBox(
              width: 160,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image:
                              product.images.isNotEmpty
                                  ? NetworkImage(product.images.first.src)
                                  : const AssetImage('assets/placeholder.png')
                                      as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Rs ${product.price}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),

                            /// 🛒 Cart Toggle Button (Add/Remove)
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                final cartCubit = context.read<CartCubit>();
                                final isInCart = cartCubit.isInCart(product.id);

                                return GestureDetector(
                                  onTap: () {
                                    if (isInCart) {
                                      cartCubit.removeFromCart(product.id);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Removed from cart'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      cartCubit.addToCart(product);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Added to cart'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color:
                                          isInCart ? Colors.red : Colors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isInCart
                                          ? Icons.remove_shopping_cart
                                          : Icons.shopping_cart,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Heart icon positioned at the top right corner
            Positioned(
              top: 8,
              right: 8,
              child: BlocBuilder<WishlistCubit, List<int>>(
                builder: (context, wishlist) {
                  final isInWishlist = wishlist.contains(product.id);

                  return GestureDetector(
                    onTap: () {
                      if (isInWishlist) {
                        context.read<WishlistCubit>().removeFromWishlist(
                          product.id,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Removed from wishlist'),
                          ),
                        );
                      } else {
                        context.read<WishlistCubit>().addToWishlist(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to wishlist')),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        size: 24,
                        color: isInWishlist ? Colors.red : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCircle extends StatelessWidget {
  final String name;
  final String image;
  const _CategoryCircle({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(backgroundImage: AssetImage(image), radius: 30),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
