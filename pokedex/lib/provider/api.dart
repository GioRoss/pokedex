import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchPokemon() async {
  final List<Map<String, dynamic>> pokemonList = [];

  // String _getColorFromType(String type) {
  //   String type = '';

  //   switch (type) {
  //     case 'grass':
  //       type = 'green';
  //       break;
  //     case 'electric':
  //       type = 'yellow';
  //       break;
  //     case 'fire':
  //       type = 'red';
  //       break;
  //     case 'normal':
  //       type = 'grey';
  //       break;
  //     default:
  //       type = 'none';
  //       break;
  //   }

  //   return type;
  // }

  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=500'));

  try {
    final decodedJson = json.decode(response.body);
    final pokemonResults = decodedJson['results'];

    for (final pokemon in pokemonResults) {
      final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
      final pokemonJson = json.decode(pokemonResponse.body);
      pokemonList.add({
        'name': pokemonJson['name'],
        'esperienza_base': pokemonJson['base_experience'],
        'abilita':
            pokemonJson['abilities'].map((e) => e['ability']['name']).toList(),
        'altezza': pokemonJson['height'],
        'id': pokemonJson['id'],
        'mosse': pokemonJson['moves']
            .map((e) => e['move']['name'])
            .take(10)
            .toList(),
        'apparizione_giochi': pokemonJson['game_indices']
            .map((e) => e['version']['name'])
            .take(5)
            .toList(),
        'img_icona': pokemonJson['sprites']['front_default'],
        'img_icona_shiny': pokemonJson['sprites']['front_shiny'],
        'img_profilo': pokemonJson['sprites']['other']['home']['front_default'],
        'img_profilo_shiny': pokemonJson['sprites']['other']['home']
            ['front_shiny'],
        'tipo': pokemonJson['types'].map((e) => e['type']['name']).toList(),
        'peso': pokemonJson['weight']
      });
    }

    // print(pokemonList);
    return pokemonList;
  } catch (e) {
    // inserito l'ignore qui sotto per evitare il warning della funzione print()
    // ignore: avoid_print
    print(e.toString());
    return [];
  }
}
