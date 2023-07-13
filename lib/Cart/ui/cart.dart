import 'package:bloc_practice/Cart/bloc/cart_bloc.dart';
import 'package:bloc_practice/Cart/model/products_model.dart';
import 'package:bloc_practice/Cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBloc.add(InititalBuildNFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        // ignore: unnecessary_type_check
        buildWhen: (previous, current) => current is CartState,
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            
            case CartBuildSuccess:
              CartBuildSuccess successState = state as CartBuildSuccess;
              if (successState.cart.length != 0) {
                return ListView.builder(
                  itemCount: successState.cart.length,
                  itemBuilder: (context, index) {
                    CartProducts itemAtPos = successState.cart[index];
                    return Cart_tile_widget(
                        cartBloc: cartBloc, tileData: itemAtPos);
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No products in cart",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }
            case CartBuildingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Center(
                child: Text(
                  "Some error occured",
                  style: TextStyle(fontSize: 20),
                ),
              );
          }
        },
      ),
    );
  }
}
