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

  void scaffoldMessengerTeam(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(193, 0, 0, 0),
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void toggleTeam(Pokemon pokemon, Pokedex poke) {
    if (!pokemon.isTeam && poke.pokemonTeamCount < 6) {
      poke.addPokemonTeam(pokemon.id);
      scaffoldMessengerTeam(
          'Aggiunto ${poke.capitalize(pokemon.nome)} alla Squadra!!');
    } else if (pokemon.isTeam) {
      poke.removePokemonTeam(pokemon.id);
      scaffoldMessengerTeam(
          'Rimosso ${poke.capitalize(pokemon.nome)} dalla Squadra!!');
    } else {
      scaffoldMessengerTeam(
          'Squadra Piena, Non è stato possibile aggiungere ${poke.capitalize(pokemon.nome)} alla Squadra!');
    }

    if (poke.pokemonTeamCount < 6) {
      poke.toggleTeamStatus(
        pokemon.id,
      );
    }
  }

  void toggleFavorite(Pokemon pokemon, Pokedex poke) {
    if (!pokemon.isFavorite) {
      scaffoldMessengerTeam(
          'Aggiunto ${poke.capitalize(pokemon.nome)} ai Preferiti!!');
    } else if (pokemon.isFavorite) {
      scaffoldMessengerTeam(
          'Rimosso ${poke.capitalize(pokemon.nome)} dai Preferiti!!');
    } else {
      scaffoldMessengerTeam(
          '${poke.capitalize(pokemon.nome)} non è stato aggiunto!!');
    }

    poke.toggleFavoriteStatus(pokemon.id);
  }

  @override
  Widget build(BuildContext context) {
    double scaleFactor = 1.0;
    final width = MediaQuery.of(context).size.width * scaleFactor;
    // final height = MediaQuery.of(context).size.height * scaleFactor;
    final orientation = MediaQuery.of(context).orientation;

    final pokemonData = Provider.of<Pokedex>(context);
    final pokemon = pokemonData.pokemonList;

    if (orientation == Orientation.landscape) {
      scaleFactor = 0.5;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('POKEDEX'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.4,
                crossAxisCount: width < 400
                    ? 1
                    : width > 1000
                        ? 4
                        : width > 800
                            ? 3
                            : 2,
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
                              child: Image(
                                image: AssetImage(
                                  'images/pokeball.png',
                                ),
                                height: width > 1200 || width < 400 ? 150 : 100,
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
                                  height:
                                      width > 1200 || width < 400 ? 150 : 100,
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
                                  ...pokemonData.getPokemonType(
                                      pokemon[index].tipo, width),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Text(
                                "#${pokemon[index].id} ${pokemonData.capitalize(pokemon[index].nome)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width > 1200 ||
                                          (width < 400 && width > 270)
                                      ? 25
                                      : 20,
                                  color: Colors.white,
                                  shadows: const [
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
                              right: width > 1200 ? 5 : -2,
                              child: Consumer<Pokedex>(
                                builder: (ctx, poke, child) => IconButton(
                                  icon: Icon(
                                      pokemon[index].isFavorite
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      size: width > 1200 ? 35 : 25,
                                      color:
                                          pokemon[index].tipo[0] != 'electric'
                                              ? Colors.amber
                                              : Colors.black),
                                  onPressed: () =>
                                      toggleFavorite(pokemon[index], poke),
                                ),
                              ),
                            ),
                            Positioned(
                              right: width > 1200 ? 40 : 25,
                              child: Consumer<Pokedex>(
                                builder: (ctx, poke, child) => IconButton(
                                  icon: Icon(
                                      pokemon[index].isTeam
                                          ? Icons.remove_rounded
                                          : Icons.add_rounded,
                                      size: width > 1200 ? 35 : 25,
                                      color:
                                          pokemon[index].tipo[0] != 'electric'
                                              ? Colors.amber
                                              : Colors.black),
                                  onPressed: () =>
                                      toggleTeam(pokemon[index], poke),
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
