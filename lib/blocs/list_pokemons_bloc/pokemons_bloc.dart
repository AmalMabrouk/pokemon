import 'package:bakersofttest/injection.dart';
import 'package:bakersofttest/services/data_service.dart';
import 'package:bakersofttest/models/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemons_state.dart';

part 'pokemons_event.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  DataService dataService = locator<DataService>();

  PokemonsBloc() : super(LoadingState()) {
      on<LoadEvent>((event, emit) async {
      List<Pokemon> products = await dataService.getPokemons(0);
      emit(LoadedState(pokemons: products));
    });
    on<PokemonFetchEvent>((event, emit) async {
      final state = this.state as LoadedState;
      emit(LoadedState(pokemons: state.pokemons,isFetching: true));
      List<Pokemon> pokemons =
          await dataService.getPokemons(state.pokemons.length);
      List<Pokemon> stateList = List.from(state.pokemons);
      stateList.addAll(pokemons);
      emit(LoadedState(pokemons: stateList,isFetching: false));
    });
  }
}
