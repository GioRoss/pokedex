import 'package:flutter/material.dart';
import 'package:pokedex/widgets/card_home_page.dart';
import 'package:pokedex/screens/list_pokemon_team.dart';

import 'list_favorite_pokemon.dart';
import 'lista_pokemon_screens.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MediaQuery.of(context).orientation == Orientation.portrait ||
            MediaQuery.of(context).platformBrightness == Brightness.light
        ? Container(
            padding: const EdgeInsets.all(10),
            child: GridView(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width > 1700
                    ? 650
                    : width > 1590
                        ? 550
                        : width > 1140
                            ? 500
                            : width > 990
                                ? 350
                                : 300,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: <Widget>[
                CardHomePage(
                  colore1: Theme.of(context).primaryColor,
                  colore2: Theme.of(context).primaryColor,
                  rotta: ListaPokemon.routeName,
                  testo: 'pokemon',
                  immagine: 'assets/images/123456.png',
                ),
                CardHomePage(
                  colore1: Theme.of(context).colorScheme.secondary,
                  colore2: Theme.of(context).colorScheme.secondary,
                  rotta: ListaPokemonTeam.routeName,
                  testo: 'squadra',
                  icona: Icons.favorite,
                  coloreIcona: Colors.red,
                ),
                CardHomePage(
                  colore1: Theme.of(context).colorScheme.primary,
                  colore2: Theme.of(context).colorScheme.primary,
                  rotta: ListaPokemonFavoriti.routeName,
                  testo: 'preferiti',
                  icona: Icons.stars,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: CardHomePage(
                    colore1: Theme.of(context).primaryColor,
                    colore2: Theme.of(context).primaryColor,
                    rotta: ListaPokemon.routeName,
                    testo: 'pokemon',
                    immagine: 'assets/images/123456.png',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: CardHomePage(
                    colore1: Theme.of(context).colorScheme.secondary,
                    colore2: Theme.of(context).colorScheme.secondary,
                    rotta: ListaPokemonTeam.routeName,
                    testo: 'squadra',
                    icona: Icons.favorite,
                    coloreIcona: Colors.red,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: CardHomePage(
                    colore1: Theme.of(context).colorScheme.primary,
                    colore2: Theme.of(context).colorScheme.primary,
                    rotta: ListaPokemonFavoriti.routeName,
                    testo: 'preferiti',
                    icona: Icons.stars,
                  ),
                ),
              ],
            ),
          );
  }
}
