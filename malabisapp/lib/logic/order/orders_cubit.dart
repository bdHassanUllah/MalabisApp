import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/logic/order/orders_state.dart';

class OrdersPlaceCubit extends Cubit<OrderPlaceState> {
  final OrderPlaceRepository orderRepository;
  final AuthCubit authCubit;

  OrdersPlaceCubit(this.orderRepository, this.authCubit) : super(OrderInitial());

  Future<void> placeOrder(CreateOrderRequestDto orderData, int customerId) async {
    emit(OrderLoading());
    try {
      final authState = authCubit.state;
      if (authState is AuthAuthenticated) {
        orderData.customerId = authState.userId!;

        final order = await orderRepository.placeOrder(orderData.toJson(), orderData.customerId);
        
        // The order object now has the order ID
        emit(OrderPlaced(order)); // You can access order.id in UI
      } else {
        emit(OrderFailure('User not authenticated'));
      }
    } catch (e) {
      emit(OrderFailure('Failed to place order: $e'));
    }
  }
}
