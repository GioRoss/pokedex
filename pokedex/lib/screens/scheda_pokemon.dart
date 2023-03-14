import 'package:flutter/material.dart';
import 'lista_pokemon_screens.dart';

class SchedaPokemon extends StatefulWidget {
  static const routeName = '/scheda-pokemon';
  ListaPokemonState listaPokemon = ListaPokemonState();

  @override
  State<SchedaPokemon> createState() => _SchedaPokemonState();
}

class _SchedaPokemonState extends State<SchedaPokemon> {
  String pokemonNome = "";
  Color? pokemonColore;
  List<dynamic> pokemonTipo = [];
  int? pokemonId;
  String pokemonImg = "";
  int pokemonEsperienza = 0;
  List<dynamic> pokemonAbilita = [];
  int pokemonAltezza = 0;
  List<dynamic> pokemonMosse = [];
  int pokemonPeso = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    pokemonNome = routeArgs['nome'];
    pokemonTipo = routeArgs['tipo'];
    pokemonColore = routeArgs['colore'];
    pokemonId = routeArgs['id'];
    pokemonImg = routeArgs['img'];
    pokemonEsperienza = routeArgs['esperienza'];
    pokemonAbilita = routeArgs['abilita'];
    pokemonAltezza = routeArgs['altezza'];
    pokemonMosse = routeArgs['mosse'];
    pokemonPeso = routeArgs['peso'];

    return Scaffold(
      // appBar: AppBar(title: const Text('DETTAGLI POKEMON')),
      backgroundColor: pokemonColore,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 3,
            left: 9,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemonNome,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "#$pokemonId",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 22,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 5,
              children: [
                ...widget.listaPokemon.getPokemonType(pokemonTipo),
              ],
            ),
          ),
          Positioned(
            top: height * 0.18,
            right: -30,
            child: Image.asset(
              '../../assets/images/pokeball.png',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.53,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Nome:',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                pokemonNome,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Altezza: ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                '${pokemonAltezza.toString()}.0 cm',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Peso: ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                '${pokemonPeso.toString()}.0 gr',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Abilità: ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...pokemonAbilita
                                      .map(
                                        (abilita) => Text(
                                          widget.listaPokemon
                                              .capitalize(abilita)
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Mosse: ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...pokemonMosse
                                      .map(
                                        (mossa) => Text(
                                          widget.listaPokemon
                                              .capitalize(mossa)
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.45,
                              child: const Text(
                                'Esperienza Iniziale: ',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                pokemonEsperienza.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: (height / 2) - 5,
            left: (width / 2) - 10,
            child: Image.network(
              pokemonImg,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
