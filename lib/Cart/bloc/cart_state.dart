part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartBuildSuccess extends CartState {
  final List<CartProducts> cart;

  CartBuildSuccess({required this.cart});
}

class CartBuildFailed extends CartState {}

class CartBuildingState extends CartState {}
