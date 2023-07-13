import 'package:bloc_practice/Cart/ui/cart.dart';
import 'package:bloc_practice/Favorites/ui/favorites.dart';
import 'package:bloc_practice/Home/bloc/home_bloc.dart';
import 'package:bloc_practice/Home/models/products_model.dart';
import 'package:bloc_practice/Home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(InitialHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is GoToCartActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ));
        } else if (state is GoToFavoritesActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Favorites(),
              ));
        } else if (state is ProoductAlreadyExistsInFavoritesListActionState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Product Already Exists in Favorites"),
              behavior: SnackBarBehavior.floating,
            ));
        } else if (state is ProoductAddedToFavoritesListActionState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("Product Added To Favorites"),
              behavior: SnackBarBehavior.floating,
            ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DataLoadingState:
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: SafeArea(
                  child: Center(
                child: CircularProgressIndicator(),
              )),
            );
          // break;
          case DataLoadedState:
            var successState = state as DataLoadedState;
            List<Products> data = successState.products;

            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                title: const Text("Home Page"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(NavigateToFavoritesEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      // onPressed: null,
                      onPressed: () {
                        homeBloc.add(NavigateToCartEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined))
                ],
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductTile(
                    tileData: data[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          // break;
          case DataLoadingErrorState:
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: Center(
                child: Text(
                  "Some Error Occurred",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          default:
            return const Scaffold(
              body: SafeArea(
                  child: Center(
                child: CircularProgressIndicator(),
              )),
            );
        }
      },
    );
  }
}
