import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malabis_app/StateProvider/addRemoveState_provider.dart';
import 'package:malabis_app/Widgets/bottomNavBar_widgets.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int price = 880;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider); // Watch quantity changes

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
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
                  // "-" Button: Decrease quantity (minimum 1)
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        ref.read(quantityProvider.notifier).state--; // Update state
                      }
                    },
                  ),
                  Text('$quantity', style: TextStyle(fontSize: 18)),
                  // "+" Button: Increase quantity
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      ref.read(quantityProvider.notifier).state++; // Update state
                    },
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomButtonWidget(
                      text: "Add to Cart ($quantity)", // Show quantity in button
                      textColor: Colors.black, 
                      onPressed: (){},
                      borderColor: Colors.black,
                    ),
                  )
                ],
              ),
              
              SizedBox(height: 16),
              ExpansionTile(title: Text('Description'), children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Scratch & Corrosion Free Glass Cleaner, which may also be used on all hard surfaces to have a neat and clean look.'),
                )
              ]),
              ExpansionTile(title: Text('Use'), children: [Text('Usage instructions here')]),
              ExpansionTile(title: Text('Direction for Use'), children: [Text('Directions here')]),
              ExpansionTile(title: Text('Warnings'), children: [Text('Warnings details here')]),
              ExpansionTile(title: Text('Safety Datasheet'), children: [Text('Safety details here')]),
              ExpansionTile(title: Text('PSCIR Report'), children: [Text('PSCIR report details here')]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: IgnorePointer( // ✅ Makes it non-interactive
    ignoring: true,
    child: BottomNavBarWidget(),
  ),
    );
  }
}
