import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<List<int>> {
  WishlistCubit() : super([]);

  // Add product to wishlist
  void addToWishlist(int productId) {
    if (!state.contains(productId)) {
      emit(List.from(state)..add(productId));
    }
  }

  // Remove product from wishlist
  void removeFromWishlist(int productId) {
    emit(state.where((id) => id != productId).toList());
  }

  void clearWishlist() {
    emit([]);
  }

  // Check if product is in the wishlist
  bool isInWishlist(int productId) {
    return state.contains(productId);
  }
}
