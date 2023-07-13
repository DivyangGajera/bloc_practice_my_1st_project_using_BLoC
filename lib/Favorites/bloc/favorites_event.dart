part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class InitialFavoritesListFetchingEvent extends FavoritesEvent {}

class RemoveFromFavoritesListEvent extends FavoritesEvent {
  final Products productToBeRemoved;

  RemoveFromFavoritesListEvent({required this.productToBeRemoved});
}
