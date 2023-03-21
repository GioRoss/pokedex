import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/pokedex.dart';
import '../provider/pokemon.dart';
import 'lista_pokemon_screens.dart';

class SchedaPokemon extends StatefulWidget {
  static const routeName = '/scheda-pokemon';
  @override
  State<SchedaPokemon> createState() => _SchedaPokemonState();
}

class _SchedaPokemonState extends State<SchedaPokemon> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final pokemonData = Provider.of<Pokedex>(context);
    final pokemon = Provider.of<Pokemon>(context);

    final pokemonNome = pokemon.nome.toUpperCase();
    final pokemonTipo = pokemon.tipo;
    final pokemonColore = pokemonData.getPokemonTypeColor(pokemon.tipo);
    final pokemonId = pokemon.id;
    final pokemonImg = pokemon.imgProfilo;
    final pokemonEsperienza = pokemon.esperienzaBase;
    final pokemonAbilita = pokemon.abilita;
    final pokemonAltezza = pokemon.altezza;
    final pokemonMosse = pokemon.mosse;
    final pokemonPeso = pokemon.peso;

    return Scaffold(
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
                ...pokemonData.getPokemonType(pokemonTipo),
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
                                          pokemonData
                                              .capitalize(abilita)
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
                                          pokemonData
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
