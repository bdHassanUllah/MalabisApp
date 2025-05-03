import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:malabis_app/Screens/splash_screen.dart';
import 'package:malabis_app/StateProvider/NavStateProvider.dart';
import 'package:malabis_app/Widgets/bottomNavBar_widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController()); // ✅ Initialize GetX NavigationController
  runApp(
    ProviderScope( // ✅ Wrap with ProviderScope to enable Riverpod
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Malabis App',
      home: SplashScreen(), // ✅ Start from SplashScreen
    );
  }
}

class MainScreen extends StatelessWidget {
  final NavigationController navController = Get.find(); // ✅ Use Get.find()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: navController.selectedIndex.value,
            children: navController.pages,
          )),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
