import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/navigation/navigation_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        User? user;
        if (state is AuthAuthenticated) {
          user = state.user;
        }

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2E323D),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xFF2E323D),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromARGB(174, 252, 252, 252),
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                ref.read(bottomNavProvider.notifier).setIndex(index, context);
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Cart",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: 'OrderHistory',
                ),
                BottomNavigationBarItem(
                  icon: user != null && user.photoURL != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                          radius: 12,
                        )
                      : const Icon(Icons.account_circle),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
