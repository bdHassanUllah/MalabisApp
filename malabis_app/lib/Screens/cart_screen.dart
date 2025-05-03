import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malabis_app/Screens/summary_screen.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';

// Quantity provider for managing individual item quantity
final cartQuantityProvider = StateProvider.family<int, String>((ref, id) => 1);

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Light grey background
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for Anything',
              prefixIcon: Icon(Icons.search, color: Colors.black54), // Search icon color
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  CartItem(id: '1', image: 'assets/glass_cleaner.png', title: 'Glass & Window Cleaner', price: 880),
                  CartItem(id: '2', image: 'assets/peeler.png', title: 'Potato Peeler with Blemish Remover', price: 1200),
                  CartItem(id: '3', image: 'assets/doll.png', title: 'Nurah Doll', price: 1599),
                ],
              ),
            ),
            SizedBox(height: 10),
            CustomButtonWidget(
              text: "Check Out",
              textColor: Colors.white,
              color: Colors.amber.shade700,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SummaryScreen()));
              }
                    
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends ConsumerWidget {
  final String id;
  final String image;
  final String title;
  final int price;

  CartItem({required this.id, required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(cartQuantityProvider(id));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 80, color: Colors.grey);
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Rs. ${price * quantity}',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    ref.read(cartQuantityProvider(id).notifier).state--;
                  }
                },
              ),
              Text('$quantity', style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  ref.read(cartQuantityProvider(id).notifier).state++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
