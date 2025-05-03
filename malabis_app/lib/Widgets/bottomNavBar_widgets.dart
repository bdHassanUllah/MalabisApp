import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malabis_app/StateProvider/NavStateProvider.dart';

class BottomNavBarWidget extends StatelessWidget {
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.black, // Background color applied here
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Ensures background works
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeTabIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent, // Keep transparent to use container color
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ));
  }
}
