import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"image": "assets/images/adhesive.png", "name": "Adhesive"},
    {"image": "assets/images/cleaner.png", "name": "All Purpose Cleaner"},
    {"image": "assets/images/backpacks.png", "name": "Backpacks"},
    {"image": "assets/images/bakery.png", "name": "Bakery"},
    {"image": "assets/images/baking.png", "name": "Baking"},
    {"image": "assets/images/bed_accessories.png", "name": "Bed Accessories"},
    {"image": "assets/images/blister_packing.png", "name": "Blister Packing"},
    {"image": "assets/images/business.png", "name": "Business"},
    {"image": "assets/images/coat_hacks.png", "name": "Coat Hacks"},
    {
      "image": "assets/images/cocoa_chocolates.png",
      "name": "Cocoa & Chocolates",
    },
    {"image": "assets/images/phenyl.png", "name": "Phenyl"},
    {"image": "assets/images/dish_wash_gel.png", "name": "Dish Wash Gel"},
    {"image": "assets/images/disinfectant.png", "name": "Disinfectant"},
    {"image": "assets/images/drain_opener.png", "name": "Drain Opener"},
    {"image": "assets/images/duffer_bags.png", "name": "Duffer Bags & Totes"},
    {"image": "assets/images/felco.png", "name": "Felco"},
    {"image": "assets/images/flavors.png", "name": "Flavors"},
    {"image": "assets/images/floor_machine.png", "name": "Floor Machine"},
    {"image": "assets/images/fondant.png", "name": "Fondant"},
    {"image": "assets/images/food_colors.png", "name": "Food Colors"},
    {"image": "assets/images/gamepro.png", "name": "Gamepro"},
    {"image": "assets/images/hand_wash.png", "name": "Hand Wash"},
    {"image": "assets/images/handles.png", "name": "Handles"},
    {"image": "assets/images/health.png", "name": "Health &"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.black54),
                        SizedBox(width: 10),
                        Text(
                          "Search for Anything",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 22,
                  child: Icon(Icons.shopping_cart, color: Colors.black),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Category Title
            Text(
              "Search by Category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            // Category Grid
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 items per row
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          categories[index]["image"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        categories[index]["name"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
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
