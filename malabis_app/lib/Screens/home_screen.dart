import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:malabis_app/DetailScreen/productdetailscreen.dart';
import 'package:malabis_app/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> carouselImages = [
    'lib/assets/images/MalabisLogo.png',
    'lib/assets/images/MalabisLogo.png',
  ];

  final List<Map<String, String>> products = [
    {
      'image': 'lib/assets/images/MalabisLogo.png',
      'name': 'Glass & Window Cleaner',
      'price': 'Rs 880',
    },
    {
      'image': 'lib/assets/images/MalabisLogo.png',
      'name': 'Agenda- Jaffer Brothers',
      'price': 'Rs 18,900',
    },
    {
      'image': 'lib/assets/images/MalabisLogo.png',
      'name': 'Compact Laptop Backpack',
      'price': 'Rs 40,000',
    },
    {
      'image': 'lib/assets/images/MalabisLogo.png',
      'name': 'Millennium Fondant',
      'price': 'Rs 1,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search for Anything",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            CarouselSlider(
              items: carouselImages.map((image) => Image.asset(image)).toList(),
              options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Latest Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to PostDetailScreen with product details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset(products[index]['image']!),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(products[index]['name']!),
                        ),
                        Text(
                          products[index]['price']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.orange),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
