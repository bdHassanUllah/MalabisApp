import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:malabis_app/routes/routes_name.dart'; // Add animate_do for nice animations

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 30),
                FadeInDown(
                  delay: const Duration(milliseconds: 500),
                  child: const Text(
                    'Thank You!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: const Text(
                    'Your order has been placed successfully.\nIt will be coming soon!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ZoomIn(
                  delay: const Duration(milliseconds: 1200),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false); // Go back or you can navigate home
                    },
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
