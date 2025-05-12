// // navigation_cubit.dart
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NavigationState {
//   final int selectedIndex;

//   NavigationState({required this.selectedIndex});
// }

// class NavigationCubit extends Cubit<NavigationState> {
//   NavigationCubit() : super(NavigationState(selectedIndex: 0));

//   void updateIndex(int index) {
//     emit(NavigationState(selectedIndex: index));
//   }
// }

import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, int>(
  (ref) => BottomNavNotifier(),
);

class BottomNavNotifier extends StateNotifier<int> {
  BottomNavNotifier() : super(0);

  void setIndex(int index, BuildContext context) {
    if (state == index) return; // Prevent duplicate navigation

    state = index; // Update the selected tab

    // Check if user is logged in
    //final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // Navigate based on the index
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, '/cartscreen', (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, '/wishlistscreen', (route) => false);
        break;
      
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, '/orderscreen', (route) => false);
        break;
      
      case 4:
        Navigator.pushNamedAndRemoveUntil(context, '/accounts', (route) => false);
        break;
      // // case 2:
      // //   //if (isLoggedIn) {
      // //     Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
      // //   } 
      // //   else {
      // //     Navigator.pushNamedAndRemoveUntil(context, '/loginscreen', (route) => false);
      // //   }
      // break;
    }
  }
}