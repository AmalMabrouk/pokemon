import 'package:bakersofttest/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:bakersofttest/injection.dart';
import 'package:bakersofttest/views/pokemons_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [

          BlocProvider(
              create: (context) => FavoriteBloc()..add(LoadFavoriteEvent()))
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: PokemonsView()));
  }
}
