import 'dart:async';
import 'dart:convert';
import 'package:bloc_practice/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Home/models/products_model.dart';


part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<InitialFavoritesListFetchingEvent>(initialFavoritesListFetchingEvent);
    on<RemoveFromFavoritesListEvent>(removeFromFavoritesListEvent);
  }

  FutureOr<void> initialFavoritesListFetchingEvent(
      InitialFavoritesListFetchingEvent event,
      Emitter<FavoritesState> emit) async {
    emit(FavoritesListLoadedState(products: favoritesList));
  }

  Future<FutureOr<void>> removeFromFavoritesListEvent(
      RemoveFromFavoritesListEvent event, Emitter<FavoritesState> emit) async {
    favoritesList.remove(event.productToBeRemoved);

    List<Map> data =
        favoritesList.map((e) => Products.productsToJson(e)).toList();
    String jsonData = jsonEncode(data);

    http.Response res = await http.put(favoritesUrl, body: jsonData);
    debugPrint("${res.statusCode}");
    emit(FavoritesListLoadedState(products: favoritesList));
  }
}
