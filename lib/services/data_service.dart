import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:bakersofttest/models/pokemon.dart';
import 'package:injectable/injectable.dart';

@injectable
class DataService {
  Future<List<Pokemon>> getPokemons(
    int offset,
  ) async {
    var response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=20"));
    Map<String, dynamic> jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<Pokemon> pokemons = List<Pokemon>.from(
        jsonResponse["results"].map((model) => Pokemon.fromJson(model)));

    return pokemons;
  }

  Future<Pokemon> getDetails(Pokemon pokemon) async {
    var response = await http.get(Uri.parse(pokemon.url));
    Map<String, dynamic> jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<String> types = List<String>.from(
        jsonResponse["types"].map((model) => model["type"]["name"]));
    Pokemon p = Pokemon(
        name: pokemon.name,
        url: pokemon.url,
        types: types,
        imageUrl: jsonResponse["sprites"]["back_default"]);

    return p;
  }
}
