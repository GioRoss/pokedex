import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'pokemon.dart';

class Pokedex with ChangeNotifier {
  List<Pokemon> _pokemonList = [];
  final List<Pokemon> _pokemonMyTeam = [];
  final storage = FlutterSecureStorage();

  Future<void> fetchPokemon() async {
    final datiSalvati = await storage.read(key: 'pokedex');

    if (datiSalvati != null) {
      _pokemonList = (jsonDecode(datiSalvati) as List<dynamic>)
          .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
          .toList();
      notifyListeners();
      return;
    }

    if (_pokemonList.isNotEmpty) {
      return;
    }

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
            imgIcona: pokemonJson['sprites']['front_default'],
            imgProfilo: pokemonJson['sprites']['other']['home']
                ['front_default'],
            tipo: pokemonJson['types'].map((e) => e['type']['name']).toList(),
            peso: pokemonJson['weight'],
            isFavorite: false,
            isTeam: false,
          ),
        );
      }

      await storage.write(
        key: 'pokedex',
        value: jsonEncode(
          _pokemonList,
        ),
      );

      print('dati da richiesta');
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  List<Pokemon> get pokemonList {
    return [..._pokemonList];
  }

  List<Pokemon> get favoritePokemon {
    return _pokemonList.where((element) => element.isFavorite).toList();
  }

  int get pokemonTeamCount {
    return _pokemonMyTeam.length;
  }

  List<Pokemon> get teamPokemon {
    _pokemonMyTeam
        .sort((pokemon1, pokemon2) => pokemon1.id.compareTo(pokemon2.id));
    return _pokemonMyTeam;
  }

  void toggleFavoriteStatus(int id) async {
    _pokemonList[id - 1].isFavorite = !_pokemonList[id - 1].isFavorite;
    await storage.write(
      key: 'pokedex',
      value: jsonEncode(_pokemonList),
    );
    notifyListeners();
  }

  void toggleTeamStatus(int id) async {
    _pokemonList[id - 1].isTeam = !_pokemonList[id - 1].isTeam;
    await storage.write(
      key: 'pokedex',
      value: jsonEncode(_pokemonList),
    );
    notifyListeners();
  }

  void addPokemonTeam(int id) {
    _pokemonMyTeam.add(_pokemonList[id - 1]);
    notifyListeners();
  }

  void removePokemonTeam(int id) {
    _pokemonMyTeam
        .removeWhere((pokemon) => pokemon.id == _pokemonList[id - 1].id);
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

  List<Widget> getPokemonType(List<dynamic> tipo, double width) {
    return tipo
        .map(
          (ele) => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Text(
              capitalize(ele),
              style: TextStyle(
                color: Colors.white,
                fontSize: width == 0
                    ? 12
                    : width > 1200 || (width < 400 && width > 270)
                        ? 20
                        : 17,
                shadows: const [
                  BoxShadow(
                    color: Colors.blueGrey,
                    offset: Offset(0, 0),
                    spreadRadius: 1.0,
                    blurRadius: 15,
                  ),
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
