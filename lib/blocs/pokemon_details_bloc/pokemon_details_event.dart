part of 'pokemon_details_bloc.dart';

@immutable
abstract class PokemonDetailsEvent {}

class LoadEvent extends PokemonDetailsEvent {
  Pokemon pokemon;
  LoadEvent({required this.pokemon});
}


