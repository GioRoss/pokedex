import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokedex.dart';
import 'package:pokedex/screens/lista_pokemon_screens.dart';
import 'package:pokedex/screens/scheda_pokemon.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';
import 'screens/list_favorite_pokemon.dart';
import 'screens/list_pokemon_team.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Pokedex>(
          create: (context) => Pokedex(),
        )
      ],
      child: MaterialApp(
        title: 'Pokemon',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.red,
              secondary: Colors.grey.shade300,
              tertiary: Colors.blue.shade200),
        ),
        home: _PokemonApp(),
        routes: {
          ListaPokemon.routeName: (ctx) => ListaPokemon(),
          SchedaPokemon.routeName: (ctx) => SchedaPokemon(),
          ListaPokemonFavoriti.routeName: (ctx) => ListaPokemonFavoriti(),
          ListaPokemonTeam.routeName: (ctx) => ListaPokemonTeam(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _PokemonApp extends StatefulWidget {
  @override
  PokemonApp createState() => PokemonApp();
}

class PokemonApp extends State<_PokemonApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pokemonLogo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawer(),
      body: HomePage(),
    );
  }
}
