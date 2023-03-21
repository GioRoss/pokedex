import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

class Pokedex with ChangeNotifier {
  final List<Pokemon> _pokemonList = [];
  final List<Pokemon> pokemonMyTeam = [];
  // bool loading = false;

  Future<void> fetchPokemon() async {
    // if (loading) {
    //   return;
    // }

    // if (_pokemonList.isNotEmpty) {
    //   return;
    // }

    // loading = true;
    // notifyListeners();

    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=25'),
    );

    print('RICHIESTA HTTP COMPLETATA');

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
            imgIcona: pokemonJson['sprites']['front_default'],
            imgIconaShiny: pokemonJson['sprites']['front_shiny'],
            imgProfilo: pokemonJson['sprites']['other']['home']
                ['front_default'],
            imgProfiloShiny: pokemonJson['sprites']['other']['home']
                ['front_shiny'],
            tipo: pokemonJson['types'].map((e) => e['type']['name']).toList(),
            peso: pokemonJson['weight'],
            isFavorite: false,
            isTeam: false,
          ),
        );
      }

      // loading = false;
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      // loading = false;
      // notifyListeners();
    }
  }

  List<Pokemon> get pokemonList {
    return [..._pokemonList];
  }

  List<Pokemon> get favoritePokemon {
    return _pokemonList.where((element) => element.isFavorite).toList();
  }

  int get pokemonTeamCount {
    return pokemonMyTeam.length;
  }

  void toggleFavoriteStatus(int id) {
    _pokemonList[id - 1].isFavorite = !_pokemonList[id - 1].isFavorite;
    notifyListeners();
  }

  void toggleTeamStatus(int id) {
    _pokemonList[id - 1].isTeam = !_pokemonList[id - 1].isTeam;
    notifyListeners();
  }

  void addPokemonTeam(int id) {
    pokemonMyTeam.add(_pokemonList[id]);
    notifyListeners();
  }

  void removePokemonTeam(int id) {
    pokemonMyTeam.remove(_pokemonList[id]);
    notifyListeners();
  }

  Color getPokemonTypeColor(List<dynamic> type) {
    Color color;

    switch (type[0]) {
      case 'grass':
        color = Colors.greenAccent;
        break;
      case 'electric':
        color = Colors.amber;
        break;
      case 'fire':
        color = Colors.redAccent;
        break;
      case 'normal':
        color = Colors.black26;
        break;
      case 'water':
        color = Colors.blue;
        break;
      case 'poison':
        color = Colors.deepPurpleAccent;
        break;
      case 'rock':
        color = Colors.grey;
        break;
      case 'ground':
        color = Colors.brown;
        break;
      case 'psychic':
        color = Colors.indigo;
        break;
      case 'fighting':
        color = Colors.orange;
        break;
      case 'bug':
        color = Colors.lightGreenAccent;
        break;
      case 'ghost':
        color = Colors.deepPurple;
        break;
      default:
        color = Colors.pink;
        break;
    }

    return color;
  }

  List<Widget> getPokemonType(List<dynamic> tipo) {
    return tipo
        .map(
          (ele) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Text(
              capitalize(ele),
              style: const TextStyle(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      color: Colors.blueGrey,
                      offset: Offset(0, 0),
                      spreadRadius: 1.0,
                      blurRadius: 15),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String capitalize(String cap) {
    return cap[0].toUpperCase() + cap.substring(1);
  }
}
