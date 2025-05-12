// cart_state.dart
import 'package:malabis_app/data/model/cart_model.dart';



class CartState {
  //final List<Product> cartItems;
  final List<CartModel> cartItems;

  CartState({this.cartItems = const [],});
}
