import 'package:freezed_annotation/freezed_annotation.dart';


part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@Freezed()
class Pokemon with _$Pokemon{

  const factory Pokemon({ String? id,
    required String name,
    required String? imageUrl,
    required List<String>? types,
    required String url})=_Pokemon;
  factory Pokemon.fromJson(Map<String,dynamic> json )=>_$PokemonFromJson(json);
}