part of 'pokemon_details_bloc.dart';

@immutable
abstract class PokemonDetailsState {}

class PokemonInitial extends PokemonDetailsState {}

class LoadingState extends PokemonDetailsState {}

class DetailsLoadedState extends PokemonDetailsState {
  Pokemon pokemon;

  DetailsLoadedState({
    required this.pokemon,
  });
}
