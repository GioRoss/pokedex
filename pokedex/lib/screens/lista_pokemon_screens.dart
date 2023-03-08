import 'package:flutter/material.dart';
import '../provider/api.dart' as api;

class ListaPokemon extends StatefulWidget {
  static const routeName = '/lista-pokemon';

  @override
  State<ListaPokemon> createState() => _ListaPokemonState();
}

class _ListaPokemonState extends State<ListaPokemon> {
  List<dynamic> pokemon = [];

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      final List<dynamic> listPokemon = await api.fetchPokemon();
      setState(() {
        pokemon = listPokemon;
      });
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Color _getPokemonTypeColor(List<dynamic> type) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LISTA POKEMON'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.4,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: pokemon.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: InkWell(
                    onTap: () {},
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getPokemonTypeColor(pokemon[index]['tipo']),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -5,
                              right: -10,
                              child: Image.asset(
                                '../../assets/images/pokeball.png',
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Hero(
                                tag: index,
                                child: Image.network(
                                  pokemon[index]['img_profilo'],
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                  // placeholder: (context, url) => Center(
                                  //   child: CircularProgressIndicator(),
                                  // ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              left: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 5, bottom: 5),
                                  child: Text(
                                    pokemon[index]['tipo'][0],
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
                              ),
                            ),
                            Positioned(
                              top: 28,
                              left: 15,
                              child: Text(
                                pokemon[index]['nome'].toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
                            Positioned(
                              top: 15,
                              right: 15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.star_border_rounded,
                                  size: 32,
                                  color: Colors.amber,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
