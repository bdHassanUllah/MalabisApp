import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int price = 880;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/glass_cleaner.png',
                  height: 250,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Glass & Window Cleaner',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Rs. $price',
                  style: TextStyle(fontSize: 18, color: Colors.green)),
              Text('• Institutional Pack Can 5 Litre'),
              SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {},
                  ),
                  Text('1', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Add to Cart'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              ExpansionTile(
                title: Text('Description'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Scratch & Corrosion Free Glass Cleaner, which may also be used on all hard surfaces to have a neat and clean look.',
                    ),
                  )
                ],
              ),
              ExpansionTile(title: Text('Use'), children: [Text('Usage instructions here')]),
              ExpansionTile(title: Text('Direction for Use'), children: [Text('Directions here')]),
              ExpansionTile(title: Text('Warnings'), children: [Text('Warnings details here')]),
              ExpansionTile(title: Text('Safety Datasheet'), children: [Text('Safety details here')]),
              ExpansionTile(title: Text('PSCIR Report'), children: [Text('PSCIR report details here')]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
