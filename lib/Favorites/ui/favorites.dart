import 'package:bloc_practice/Favorites/bloc/favorites_bloc.dart';
import 'package:bloc_practice/Favorites/ui/favorites_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Home/models/products_model.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  FavoritesBloc favoritesBloc = FavoritesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoritesBloc.add(InitialFavoritesListFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Favorited Products"),
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        bloc: favoritesBloc,
        listenWhen: (previous, current) => current is FavoritesActionState,
        buildWhen: (previous, current) => current is! FavoritesActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FavoritesListLoadedState) {
            var successState = state as FavoritesListLoadedState;
            List<Products> data = successState.products;
            if (data.isNotEmpty) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Favorites_tile_widget(
                      data: data[index],
                      fav_bloc: favoritesBloc,
                    );
                  },
                  itemCount: data.length);
            } else {
              return Center(
                child: Text(
                  "No Products Added to Favorites",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
