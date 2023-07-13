import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/assets.dart';
import 'package:meta/meta.dart';

import '../model/products_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<InititalBuildNFetchEvent>(inititalBuildNFetchEvent);
  }

  Future<FutureOr<void>> inititalBuildNFetchEvent(
      InititalBuildNFetchEvent event, Emitter<CartState> emit) async {
    emit(CartBuildingState());
    await Future.delayed(Duration(milliseconds: 500),
        () => emit(CartBuildSuccess(cart: cartList)));

        
  }
}
