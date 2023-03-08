import 'package:flutter/material.dart';
import 'package:pokedex/screens/card_home_page.dart';
// import 'package:flutter_icondata/flutter_icondata.dart';

import 'lista_pokemon_screens.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
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
              icona: Icons.abc),
          CardHomePage(
            colore1: Theme.of(context).colorScheme.secondary,
            colore2: Theme.of(context).colorScheme.secondary,
            rotta: ListaPokemon.routeName,
            testo: 'la mia squadra',
            icona: Icons.favorite,
            coloreIcona: Colors.red,
          ),
          CardHomePage(
            colore1: Theme.of(context).colorScheme.primary,
            colore2: Theme.of(context).colorScheme.primary,
            rotta: ListaPokemon.routeName,
            testo: 'preferiti',
            icona: Icons.stars,
          ),
        ],
      ),
    );
  }
}
