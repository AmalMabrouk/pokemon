import 'package:bakersofttest/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:bakersofttest/blocs/list_pokemons_bloc/pokemons_bloc.dart';
import 'package:bakersofttest/models/pokemon.dart';
import 'package:bakersofttest/views/favorite_list_view.dart';
import 'package:bakersofttest/views/pokemon_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonsView extends StatelessWidget {
  const PokemonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PokemonsBloc()..add(LoadEvent())),
      ],
      child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                height: 1,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text("Pokemon"),
            titleTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          body: BlocBuilder<PokemonsBloc, PokemonsState>(
              builder: (context, state) {
            if (state is LoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 8, left: 8),
                      child: GridView.builder(
                        controller: _scrollController
                          ..addListener(() {
                            if (_scrollController.offset ==
                                    _scrollController
                                        .position.maxScrollExtent &&
                                !state.isFetching) {
                              context
                                  .read<PokemonsBloc>()
                                  .add(PokemonFetchEvent());
                            }
                          }),
                        itemCount: state.pokemons.length,
                        itemBuilder: (context, index) {
                          Pokemon product = state.pokemons[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsView(
                                          pokemon:
                                              state.pokemons.elementAt(index),
                                        )),
                              );
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              )),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.asset("assets/images/pokemon.png"),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Center(
                                              child: Text(
                                                "${product.name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 4, top: 4),
                                    child: BlocBuilder<FavoriteBloc,
                                            FavoriteState>(
                                        builder: (context, state) {
                                      if (state is FavoriteLoadedState) {
                                        return state.favoriteList
                                                .contains(product)
                                            ? IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<FavoriteBloc>()
                                                      .add(
                                                          RemoveFromFavoriteEvent(
                                                              pokemon:
                                                                  product));
                                                },
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.green,
                                                  size: 24,
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<FavoriteBloc>()
                                                      .add(AddToFavoriteEvent(
                                                          pokemon: product));
                                                },
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.green,
                                                  size: 24,
                                                ),
                                              );
                                      }
                                      return Container();
                                    }),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 8),
                      ),
                    ),
                  ),
                  state.isFetching
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        )
                      : Container()
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }),
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              backgroundColor: const Color(0xFFE57373),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteListView()),
                );
              },
              child: Icon(Icons.favorite))),
    );
  }
}
