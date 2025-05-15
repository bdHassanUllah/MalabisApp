import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<HomeCubit>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E323D),
        title: Center(child: const Text('Home Page', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, size: 30.0, color: Colors.white),
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
            final allProducts = state.products;
            final products = _searchQuery.isEmpty
                ? allProducts
                : allProducts
                    .where((product) =>
                        product.name.toLowerCase().contains(_searchQuery))
                    .toList();

            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Search bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Search products...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query.trim().toLowerCase();
                        });
                      },
                    ),
                  ),
                ),

                // Carousel
                if (products.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                        ),
                        items: products.take(3).map((product) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.images.isNotEmpty ? product.images.first.src : '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                // Product Grid
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: products.isNotEmpty
                      ? SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = products[index];
                              return ProductCard(product: product);
                            },
                            childCount: products.length,
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'No products match your search.',
                                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.pushNamed(context, detailscreen, arguments: product.toJson());
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: product.images.isNotEmpty
                            ? NetworkImage(product.images.first.src)
                            : const AssetImage('assets/placeholder.png') as ImageProvider,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Removed from cart'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    cartCubit.addToCart(product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Added to cart'),
                                      duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: isInCart ? Colors.red : Color(0xFF2E323D),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isInCart ? Icons.remove_shopping_cart : Icons.shopping_cart,
                                    size: 20,
                                    color: Colors.white,
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
                        context.read<WishlistCubit>().removeFromWishlist(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from wishlist')),
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
