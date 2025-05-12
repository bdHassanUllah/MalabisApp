import 'package:flutter/material.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<Product> products;
  HomeLoaded(this.products);
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}