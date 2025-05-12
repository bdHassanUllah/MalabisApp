
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/data/repository/home_repository.dart';
import 'package:malabis_app/logic/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;
  final List<Product> _allProducts = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> loadInitialProducts() async {
    emit(HomeLoading());
    _currentPage = 1;
    _hasMore = true;
    _allProducts.clear();

    try {
      final products = await repository.getProducts(page: _currentPage);
      _allProducts.addAll(products);

      if (products.isEmpty) _hasMore = false;

      emit(HomeLoaded(List.from(_allProducts)));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _currentPage++;

    try {
      final products = await repository.getProducts(page: _currentPage);
      if (products.isEmpty) {
        _hasMore = false;
      } else {
        _allProducts.addAll(products);
        emit(HomeLoaded(List.from(_allProducts)));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }
}
