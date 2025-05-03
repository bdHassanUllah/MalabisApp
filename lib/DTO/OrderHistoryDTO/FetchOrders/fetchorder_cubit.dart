import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/OrderHistoryDTO/FetchOrders/fetchorder_repository.dart';
import 'package:malabis_app/logic/order/orders_state.dart';

class OrderFetchCubit extends Cubit<OrderPlaceState> {
  final OrderFetchRepository repository;

  OrderFetchCubit(this.repository) : super(OrderInitial());

  Future<void> fetchOrdersByEmail(String email) async {
    emit(OrderLoading());

    try {
      final customerId = await repository.getWooCustomerIdByEmail(email);
      if (customerId != null) {
        final orders = await repository.getOrdersByCustomerId(customerId);
        emit(OrderSuccess(orders));
      } else {
        emit(OrderFailure("No WooCommerce account found for this email."));
      }
    } catch (e) {
      emit(OrderFailure("Failed to fetch orders: $e"));
    }
  }

  Future<void> fetchOrderById(int orderId) async {
    emit(OrderLoading());
    try {
      final order = await repository.getOrderById(orderId);
      if (order != null) {
        emit(OrderSuccess([order])); // wrap in a list for consistency
      } else {
        emit(OrderFailure("Order not found."));
      }
    } catch (e) {
      emit(OrderFailure("Failed to fetch order by ID: $e"));
    }
  }
}
