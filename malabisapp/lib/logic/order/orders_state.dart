// import 'package:equatable/equatable.dart';
// import 'package:malabis_app/data/model/order_model.dart';

// abstract class OrderState extends Equatable {
//   const OrderState();

//   @override
//   List<Object?> get props => [];
// }

// class OrderInitial extends OrderState {}

// class OrderLoading extends OrderState {}

// class OrderSuccess extends OrderState {
//   final List<OrderModel> orders;

//   const OrderSuccess(this.orders);

//   @override
//   List<Object?> get props => [orders];
// }

// class OrderPlaced extends OrderState {
//   final OrderModel order;

//   const OrderPlaced(this.order);

//   @override
//   List<Object?> get props => [order];
// }

// class OrderFailure extends OrderState {
//   final String error;

//   const OrderFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }


// order_state.dart
import 'package:malabis_app/data/model/order_model.dart';

abstract class OrderPlaceState {}

class OrderInitial extends OrderPlaceState {}

class OrderLoading extends OrderPlaceState {}

class OrderSuccess extends OrderPlaceState {
  final List<OrderModel> orders;

  OrderSuccess(this.orders);
}

class OrderFailure extends OrderPlaceState {
  final String error;

  OrderFailure(this.error);
}

class OrderPlaced extends OrderPlaceState {
  final OrderModel order;

  OrderPlaced(this.order);
}
