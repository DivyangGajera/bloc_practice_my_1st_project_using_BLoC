part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class NavigateToFavoritesEvent extends HomeEvent {}

class NavigateToCartEvent extends HomeEvent {}

class AddToFavoritesEvent extends HomeEvent {
  final Products clickedProduct;

  AddToFavoritesEvent({required this.clickedProduct});
}

class AddToCartEvent extends HomeEvent {
  final Products clickedProduct;

  AddToCartEvent({required this.clickedProduct});
}

