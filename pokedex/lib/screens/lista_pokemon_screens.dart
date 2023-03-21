import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pokedex/screens/scheda_pokemon.dart';
import 'package:provider/provider.dart';
import '../provider/pokedex.dart';
import '../provider/pokemon.dart';

class ListaPokemon extends StatefulWidget {
  static const routeName = '/lista-pokemon';

  const ListaPokemon({super.key});

  @override
  State<ListaPokemon> createState() => ListaPokemonState();
}

class ListaPokemonState extends State<ListaPokemon> {
  @override
  void initState() {
    Pokedex provider = Provider.of<Pokedex>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      provider.fetchPokemon();
    });
    super.initState();
  }

  void toggleTeam(Pokemon pokemon, Pokedex poke) {
    if (!pokemon.isTeam && poke.pokemonTeamCount < 6) {
      poke.addPokemonTeam(pokemon.id);
      // print('pokemon aggiunto alla squadra');
      // showDialog(
      //   context: context,
      // builder: (_) => const AlertDialog(
      //   title: Text('Aggiunto Pokemon Ciccione'),
      //   elevation: 24.0,
      //   backgroundColor: Colors.blue,
      //   // shape: CircleBorder(),
      //   // content: Text('Accetti?'),
      //   // actions: [FlatButton('no')],
      // ),
      // );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return const AlertDialog(
            title: Text('Aggiunto Pokemon Ciccione'),
            elevation: 24.0,
            backgroundColor: Colors.blue,
            // shape: CircleBorder(),
            // content: Text('Accetti?'),
            // actions: [FlatButton('no')],
          );
        },
        barrierDismissible: true,
      );
    } else if (pokemon.isTeam) {
      poke.removePokemonTeam(pokemon.id);
      print('pokemon rimosso dalla squadra, sicuro?');
    } else {
      print('squadra piena');
    }

    if (poke.pokemonTeamCount < 6) {
      poke.toggleTeamStatus(
        pokemon.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    final pokemonData = Provider.of<Pokedex>(context);
    final pokemon = pokemonData.pokemonList;

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
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: pokemon[index],
                            child: SchedaPokemon(),
                          );
                        },
                      ),
                    ),
                    // usato per l'interfaccia del telefono, per evitare che ci siano blocchi di interfaccia
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: pokemonData
                              .getPokemonTypeColor(pokemon[index].tipo),
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
                                  ...pokemonData
                                      .getPokemonType(pokemon[index].tipo),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Text(
                                "#${pokemon[index].id} ${pokemonData.capitalize(pokemon[index].nome)}",
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
                              right: -2,
                              child: Consumer<Pokedex>(
                                builder: (ctx, poke, child) => IconButton(
                                  icon: Icon(
                                      pokemon[index].isFavorite
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      size: 25,
                                      color:
                                          pokemon[index].tipo[0] != 'electric'
                                              ? Colors.amber
                                              : Colors.black),
                                  onPressed: () {
                                    poke.toggleFavoriteStatus(
                                      pokemon[index].id,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              right: 25,
                              child: Consumer<Pokedex>(
                                builder: (ctx, poke, child) => IconButton(
                                  icon: Icon(
                                      pokemon[index].isTeam
                                          ? Icons.remove_rounded
                                          : Icons.add_rounded,
                                      size: 25,
                                      color:
                                          pokemon[index].tipo[0] != 'electric'
                                              ? Colors.amber
                                              : Colors.black),
                                  onPressed: () {
                                    toggleTeam(pokemon[index], poke);
                                  },
                                ),
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
