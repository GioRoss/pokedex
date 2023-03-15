import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class Pokedex with ChangeNotifier {
  final List<Pokemon> _pokemonList = [];

  Future<List<Pokemon>> fetchPokemon() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=25'),
    );

    try {
      final decodedJson = json.decode(response.body);
      final pokemonResults = decodedJson['results'];

      for (final pokemon in pokemonResults) {
        final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
        final pokemonJson = json.decode(pokemonResponse.body);
        _pokemonList.add(
          Pokemon(
            nome: pokemonJson['name'],
            esperienzaBase: pokemonJson['base_experience'],
            abilita: pokemonJson['abilities']
                .map((e) => e['ability']['name'])
                .toList(),
            altezza: pokemonJson['height'],
            id: pokemonJson['id'],
            mosse: pokemonJson['moves']
                .map((e) => e['move']['name'])
                .take(5)
                .toList(),
            // 'apparizione_giochi': pokemonJson['game_indices']
            //     .map((e) => e['version']['name'])
            //     .take(5)
            //     .toList(),
            imgIcona: pokemonJson['sprites']['front_default'],
            imgIconaShiny: pokemonJson['sprites']['front_shiny'],
            imgProfilo: pokemonJson['sprites']['other']['home']
                ['front_default'],
            imgProfiloShiny: pokemonJson['sprites']['other']['home']
                ['front_shiny'],
            tipo: pokemonJson['types'].map((e) => e['type']['name']).toList(),
            peso: pokemonJson['weight'],
          ),
        );
      }
      return _pokemonList;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }

  List<Pokemon> get pokemonList {
    return [..._pokemonList];
  }
}
