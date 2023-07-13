part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

abstract class FavoritesActionState extends FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesListLoadingState extends FavoritesState {}

class FavoritesListLoadingErrorState extends FavoritesState {}

class FavoritesListLoadedState extends FavoritesState {
  final List<Products> products;

  FavoritesListLoadedState({required this.products});
}

