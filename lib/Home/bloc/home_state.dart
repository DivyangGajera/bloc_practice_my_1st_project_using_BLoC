part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class DataLoadingState extends HomeState {}

class DataLoadingErrorState extends HomeState {}

class DataLoadedState extends HomeState {
  final List<Products> products;


  DataLoadedState({required this.products});
}

class GoToFavoritesActionState extends HomeActionState {}

class GoToCartActionState extends HomeActionState {}

class AddedToFavoritesState extends HomeState {}

class AddedToCartState extends HomeState {}

class ProoductAddedToFavoritesListActionState extends HomeActionState {}

class ProoductAlreadyExistsInFavoritesListActionState extends HomeActionState {}
