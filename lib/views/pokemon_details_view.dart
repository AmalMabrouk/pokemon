import 'package:bakersofttest/blocs/pokemon_details_bloc/pokemon_details_bloc.dart';
import 'package:bakersofttest/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsView extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsView({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                PokemonDetailsBloc()..add(LoadEvent(pokemon: pokemon))),
      ],
      child: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
          builder: (context, state) {
        if (state is DetailsLoadedState) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: const <Widget>[],
              centerTitle: true,
              title: Text(state.pokemon.name),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  state.pokemon.imageUrl!,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 26,
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                        itemCount: state.pokemon.types!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            state.pokemon.types![index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        );
      }),
    );
  }
}
