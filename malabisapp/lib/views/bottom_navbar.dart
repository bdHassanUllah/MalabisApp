
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/navigation/navigation_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        User? user;
        if (state is AuthAuthenticated) {
          user = state.user;  // Get the authenticated user
        }
      
    return CurvedNavigationBar(
      backgroundColor: const Color(0xFFC58900), // Background behind the bar
      color: const Color(0xFF2F4568), // Nav bar color
      buttonBackgroundColor: const Color.fromARGB(88, 0, 0, 0), // Active icon background
      animationDuration: const Duration(milliseconds: 300), // Smooth animation
      index: selectedIndex, // Set selected tab
      onTap: (index) {
        ref.read(bottomNavProvider.notifier).setIndex(index, context);
      },
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: selectedIndex == 0
              ? Colors.amber
              : Colors.black, // Active: Black, Inactive: White
        ),
        Icon(
          Icons.shopping_cart,
          size: 30,
          color: selectedIndex == 1
              ? Colors.amber
              : Colors.black, // Active: Black, Inactive: White
        ),
        Icon(
          Icons.favorite,
          size: 30,
          color: selectedIndex == 2
              ? Colors.amber
              : Colors.black, // Active: Black, Inactive: White
        ),
        Icon(
          Icons.add_box_outlined,
          size: 30,
          color: selectedIndex == 3
              ? Colors.amber
              : Colors.black, // Active: Black, Inactive: White
        ),
             user != null && user.photoURL != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                    radius: 15,
                  )
                : Icon(Icons.account_circle, size: 30),
      ],
    );
  });
  }
}