import 'package:get/get.dart';
import 'package:malabis_app/Screens/home_screen.dart';
import 'package:malabis_app/screens/cart_screen.dart';
import 'package:malabis_app/screens/profile_screen.dart';
import 'package:malabis_app/screens/search_screen.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  get pages => 
  [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
