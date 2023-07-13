import 'dart:async';
import 'dart:convert';
import 'package:bloc_practice/Cart/model/products_model.dart';
import 'package:bloc_practice/data/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '../models/products_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Products> displayProductsList = [];

  HomeBloc() : super(HomeInitial()) {
    on<AddToCartEvent>(addToCart);

    on<AddToFavoritesEvent>(addToFavorites);
    on<NavigateToFavoritesEvent>(navigateToFavorites);
    on<InitialHomeEvent>(initialHomeEvent);
    on<NavigateToCartEvent>(navigateToCart);
  }

  Future<FutureOr<void>> initialHomeEvent(
      InitialHomeEvent event, Emitter<HomeState> emit) async {
    emit(DataLoadingState());

//fetching data from this URI variables

    http.Response response = await http.get(productsUrl);
    http.Response prevFavData = await http.get(favoritesUrl);
    http.Response prevCartData = await http.get(cartUrl);
    List? tempFavData = jsonDecode(prevFavData.body);
    if (tempFavData != null) {
      favoritesList = tempFavData.map((e) => Products.fromJson(e)).toList();
    }
    List? tempCartData = jsonDecode(prevCartData.body);
    if (tempCartData != null) {
      cartList = tempCartData.map((e) => CartProducts.fromJson(e)).toList();
    }
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      displayProductsList = data
          .map((e) => Products(
              image_url: e['image_url'],
              name: e['name'],
              expiry_date: e['expiry_date'],
              price: double.parse("${e['price']}")))
          .toList();
      emit(DataLoadedState(products: displayProductsList));
    } else {
      emit(DataLoadingErrorState());
    }
  }

  FutureOr<void> navigateToFavorites(
      NavigateToFavoritesEvent event, Emitter<HomeState> emit) {
    print("GotoFavorites clicked");
    emit(GoToFavoritesActionState());
  }

  FutureOr<void> navigateToCart(
      NavigateToCartEvent event, Emitter<HomeState> emit) {
    print("GotoCart clicked");
    emit(GoToCartActionState());
  }

  Future<FutureOr<void>> addToFavorites(
      AddToFavoritesEvent event, Emitter<HomeState> emit) async {
    Uri url = Uri.parse(
        "https://fir-a-to-z-default-rtdb.firebaseio.com/Favorites.json");

    if (!favoritesList.contains(event.clickedProduct)) {
      favoritesList.add(event.clickedProduct);
      List data = favoritesList.map((e) => Products.productsToJson(e)).toList();
      String jsonData = jsonEncode(data);

      await http.put(url, body: jsonData);
      emit(ProoductAddedToFavoritesListActionState());
      emit(DataLoadedState(products: displayProductsList));
    } else {
      emit(ProoductAlreadyExistsInFavoritesListActionState());
    }
  }

  Future<FutureOr<void>> addToCart(AddToCartEvent event, Emitter<HomeState> emit) async {
    int quant = 1;
    bool added = false;
    CartProducts itemAtPos = CartProducts(
        image_url: event.clickedProduct.image_url,
        name: event.clickedProduct.name,
        quantity: quant,
        expiry_date: event.clickedProduct.expiry_date,
        price: event.clickedProduct.price);

    if (cartList.length == 0) {
      cartList.add(itemAtPos);
    } else {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].name == itemAtPos.name) {
          CartProducts itemAtPos = CartProducts(
              image_url: event.clickedProduct.image_url,
              name: event.clickedProduct.name,
              quantity: cartList[i].quantity + 1,
              expiry_date: event.clickedProduct.expiry_date,
              price: event.clickedProduct.price);
          // debugPrint("$cartList");
          cartList.remove(cartList[i]);
          // debugPrint("$cartList");
          cartList.add(itemAtPos);
          // debugPrint("$cartList");
          added = true;
          debugPrint("quantity incresed ${itemAtPos.quantity}");
        } else {
          if ((i == cartList.length - 1) && !added) {
            cartList.add(itemAtPos);
            debugPrint("added 1st time");
            break;
          }
        }
        // debugPrint("$cartList");
      }
    }
    List<Map> listOfMaps = cartList.map((e) => CartProducts.productsToJson(e)).toList();
    String upload = jsonEncode(listOfMaps);
    await put(cartUrl,body: upload);
    // debugPrint("list is : $itemAtPos");
    print("AddToCart Executed");
  }
}
