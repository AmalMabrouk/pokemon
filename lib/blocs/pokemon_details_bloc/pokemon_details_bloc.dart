import 'package:bakersofttest/injection.dart';
import 'package:bakersofttest/services/data_service.dart';
import 'package:bakersofttest/models/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'pokemon_details_state.dart';

part 'pokemon_details_event.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  DataService dataService = locator<DataService>();

  PokemonDetailsBloc() : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {

      Pokemon pokemon =await dataService.getDetails(event.pokemon);
      emit(DetailsLoadedState(pokemon: pokemon));
    });


  }
}
