import 'package:flutter/material.dart';
import 'package:pokedex/screens/scheda_pokemon.dart';
import '../provider/pokedex.dart';

class ListaPokemon extends StatefulWidget {
  static const routeName = '/lista-pokemon';
  final elemento = Pokedex();

  @override
  State<ListaPokemon> createState() => ListaPokemonState();
}

class ListaPokemonState extends State<ListaPokemon> {
  List<dynamic> pokemon = [];

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      final List<dynamic> listPokemon = await widget.elemento.fetchPokemon();
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
              physics:
                  const BouncingScrollPhysics(), // usato per far rimbalzare lo scorrimento al raggiungimento della fine
              itemCount: pokemon.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      SchedaPokemon.routeName,
                      arguments: {
                        'nome': pokemon[index].nome.toUpperCase(),
                        'colore': _getPokemonTypeColor(pokemon[index].tipo),
                        'tipo': pokemon[index].tipo,
                        'id': pokemon[index].id,
                        'img': pokemon[index].imgProfilo,
                        'esperienza': pokemon[index].esperienzaBase,
                        'abilita': pokemon[index].abilita,
                        'altezza': pokemon[index].altezza,
                        'mosse': pokemon[index].mosse,
                        'peso': pokemon[index].peso,
                      },
                    ),
                    // usato per l'interfaccia del telefono, per evitare che ci siano blocchi di interfaccia
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getPokemonTypeColor(pokemon[index].tipo),
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
                                  pokemon[index].imgProfilo,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              left: 10,
                              // utilizzato per avere un layout flessibile
                              child: Wrap(
                                direction: Axis.vertical,
                                spacing: 5,
                                children: <Widget>[
                                  ...getPokemonType(pokemon[index].tipo),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Text(
                                "#${pokemon[index].id} ${capitalize(pokemon[index].nome)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
                              // top: 5,
                              right: -2,
                              child: IconButton(
                                icon: Icon(Icons.star_border_rounded,
                                    size: 25,
                                    color: pokemon[index].tipo[0] != 'electric'
                                        ? Colors.amber
                                        : Colors.black),
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
