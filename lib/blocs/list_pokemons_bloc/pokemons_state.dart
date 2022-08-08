
part of 'pokemons_bloc.dart';


@immutable
abstract class PokemonsState{}
class ProductsInitial extends PokemonsState{}

class LoadingState extends PokemonsState{}

class LoadedState extends PokemonsState{
  bool isFetching;
  List<Pokemon> pokemons = List.empty(growable: true);
  LoadedState({required this.pokemons,this.isFetching=false});
}
