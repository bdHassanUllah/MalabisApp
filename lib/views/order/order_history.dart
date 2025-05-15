import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_cubit.dart';
import 'package:malabis_app/logic/order/orders_state.dart';
import 'package:malabis_app/views/bottom_navbar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      context.read<OrderFetchCubit>().fetchOrdersByEmail(user.email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order History Screen',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E323D),
      ),
      body: BlocBuilder<OrderFetchCubit, OrderPlaceState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderSuccess) {
            final orders = state.orders;

            if (orders.isEmpty) {
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: Center(
                  key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'No orders found.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Looks like you haven\'t placed any orders yet.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                const SizedBox(height: 10), // 🛑 ADDED SizedBox between AppBar and List
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return AnimatedContainer( // 🛑 Animated Container for smooth appearance
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text('Order #${order.id}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status: ${order.status}'),
                                Text('Total: Rs${order.total}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is OrderFailure) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('Fetch your orders.'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
