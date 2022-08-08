part of 'pokemons_bloc.dart';



@immutable
abstract class PokemonsEvent{}

class LoadEvent extends PokemonsEvent{
}
class PokemonFetchEvent extends PokemonsEvent{
  PokemonFetchEvent();
}
