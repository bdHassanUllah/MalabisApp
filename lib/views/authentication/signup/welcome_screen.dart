// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
// import 'package:malabis_app/logic/authentication/authentication_state.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: BlocBuilder<AuthCubit, AuthState>(
//         builder: (context, state) {
//           // Handle loading state
//           if (state is AuthLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // Handle authenticated state
//           if (state is AuthAuthenticated) {
//             final authCubit = context.read<AuthCubit>();
//             final userId = authCubit.signInWithGoogle();

//             // If userId is available, attempt WooCommerce customer creation
//             Future.delayed(Duration.zero, () {
//               createWooCommerceCustomer(authCubit, context);
//               print("User ID: $userId");
//             });
          
//             // After user is authenticated, show the user is signed in
//             return const Center(child: Text('User is signed in'));
//           }

//           // Handle errors during authentication
//           if (state is AuthError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }

//           // Default state when user is unauthenticated
//           return Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 // Trigger Google Sign-In and handle user data after successful sign-in
//                 context.read<AuthCubit>().signInWithGoogle().then((_) {
//                   final authCubit = context.read<AuthCubit>();
//                   final userId = authCubit.signInWithGoogle();
//                   // Trigger WooCommerce customer creation after sign-in
//                   Future.delayed(Duration.zero, () {
//                     createWooCommerceCustomer(authCubit, context);
//                   });
//                                 }).catchError((error) {
//                   // Handle any errors in sign-in
//                   print('Error during sign-in: $error');
//                 });
//               },
//               child: const Text('Sign In with Google'),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Function to create WooCommerce customer
//   Future<void> createWooCommerceCustomer(AuthCubit authCubit, BuildContext context) async {
//     try {
//       final response = await createCustomerInWooCommerce(authCubit); // Your API call here

//       if (response['success']) {
//         print("User successfully created in WooCommerce.");
//         // Display success icon
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text('Success'),
//             content: Row(
//               children: const [
//                 Icon(Icons.check_circle, color: Colors.green),
//                 SizedBox(width: 10),
//                 Text('User successfully created in WooCommerce'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         print("Failed to create user in WooCommerce: ${response['message']}");
//         // Display failure icon
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text('Failure'),
//             content: Row(
//               children: const [
//                 Icon(Icons.error, color: Colors.red),
//                 SizedBox(width: 10),
//                 Text('Failed to create user in WooCommerce'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print("Error creating user in WooCommerce: $e");
//       // Display error icon
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text('Error'),
//           content: Row(
//             children: [
//               Icon(Icons.error_outline, color: Colors.orange),
//               const SizedBox(width: 10),
//               Text('Error: $e'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   // Mock function to simulate creating a customer in WooCommerce (replace with actual API call)
//   Future<Map<String, dynamic>> createCustomerInWooCommerce(AuthCubit authCubit) async {
//     // Simulating a response (replace with real API call)
//     await Future.delayed(const Duration(seconds: 2));
//     return {'success': true, 'message': 'User created successfully'}; // Mock response
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/views/home/home_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthAuthenticated) {
            final authCubit = context.read<AuthCubit>();

            Future.delayed(Duration.zero, () async {
              await createWooCommerceCustomer(authCubit, context);
            });

            return const Center(child: Text('User is signed in'));
          }

          if (state is AuthError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().signInWithGoogle().then((_) async {
                  final authCubit = context.read<AuthCubit>();
                  await createWooCommerceCustomer(authCubit, context);
                }).catchError((error) {
                  print('Error during sign-in: $error');
                });
              },
              child: const Text('Sign In with Google'),
            ),
          );
        },
      ),
    );
  }

  Future<void> createWooCommerceCustomer(AuthCubit authCubit, BuildContext context) async {
    try {
      final response = await createCustomerInWooCommerce(authCubit);

      if (response['success'] == true) {
        print("User successfully created in WooCommerce.");
        navigateToHome(context);
      } 
      else if (response['message'] == 'User already exists') {
        print("User already exists in WooCommerce.");
        navigateToHome(context);
      } 
      else {
        print("Failed to create user in WooCommerce: ${response['message']}");
        navigateToHome(context);
      }
    } catch (e) {
      print("Error creating user in WooCommerce: $e");
      navigateToHome(context);
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // Mock function: Replace this with your real WooCommerce customer creation API
  Future<Map<String, dynamic>> createCustomerInWooCommerce(AuthCubit authCubit) async {
    await Future.delayed(const Duration(seconds: 2));
    // Example response when user already exists
    return {
      'success': false,
      'message': 'User already exists',
    };
    // If user created successfully, it would be:
    // return {'success': true, 'message': 'User created successfully'};
  }
}
