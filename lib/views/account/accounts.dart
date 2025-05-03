import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/views/bottom_navbar.dart';
import '../../logic/authentication/authentication_state.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              final user = state.user;
              return AppBar(
                backgroundColor: const Color(0xFFC58900),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  user.displayName ?? 'User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade100,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : null,
                      child: user.photoURL == null
                          ? const Icon(Icons.person, color: Colors.amber)
                          : null,
                    ),
                  ),
                ],
              );
            } else {
              return AppBar(
                backgroundColor: const Color(0xFFC58900),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final user = state.user;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("My Information", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // User info
                    buildInfoRow("Name", user.displayName ?? 'Not available'),
                    buildInfoRow("Phone no", user.phoneNumber ?? 'Not provided'),
                    buildInfoRow("Email", user.email ?? 'No email'),
                    buildInfoRow("Shipping Address", "N/A"),

                    const SizedBox(height: 20),
                    const Text("My Orders", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          buildOrderRow("Order #1", "Rs. 3,150"),
                          const Divider(),
                          buildOrderRow("Order #2", "Rs. 3,150"),
                        ],
                      ),
                    ),

                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionButton("Logout", Colors.amber, Colors.white, onTap: () {
                          context.read<AuthCubit>().signOut();
                        }),
                        buildActionButton("Update Info", Colors.white, Colors.amber, border: true),
                      ],
                    ),
                  ],
                );
              } else if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await context.read<AuthCubit>().signInWithGoogle();
                        // After sign-in, you can trigger WooCommerce customer creation if needed
                      } catch (error) {
                        print('Error during Google Sign-In: $error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 3,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Image.asset(
                      'lib/assets/images/dummy_product.png', // Use your Google logo asset
                      height: 24,
                      width: 24,
                    ),
                    label: const Text('Sign in with Google'),
                  ),
                );
                //return const Center(child: Text("Please log in to see your account"));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Widget buildOrderRow(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildActionButton(String text, Color bgColor, Color textColor,
      {bool border = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: border ? Border.all(color: Colors.amber, width: 2) : null,
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
