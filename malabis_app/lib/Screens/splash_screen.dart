import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malabis_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.off(MainScreen()); // ✅ Correct navigation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Image.asset(
          'lib/assets/images/MalabisLogo.png',
          width: MediaQuery.of(context).size.width * 0.8, // Responsive width
        ),
      ),
    );
  }
}
