part of 'favorite_bloc.dart';



@immutable
abstract class FavoriteEvent{}
class LoadFavoriteEvent extends FavoriteEvent{}
class AddToFavoriteEvent extends FavoriteEvent {

  Pokemon pokemon;
  AddToFavoriteEvent({required this.pokemon});
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  Pokemon pokemon;
  RemoveFromFavoriteEvent({required this.pokemon,});}