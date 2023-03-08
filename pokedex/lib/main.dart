import 'package:flutter/material.dart';
import 'package:pokedex/screens/lista_pokemon_screens.dart';

import 'screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      theme: ThemeData(
        primarySwatch: Colors.red,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.amber,
            secondary: Colors.grey.shade300,
            tertiary: Colors.blue.shade200),
      ),
      home: _PokemonApp(),
      routes: {
        ListaPokemon.routeName: (ctx) => ListaPokemon(),
      },
      debugShowCheckedModeBanner: false,
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
        title: const Text('Pokemon'),
      ),
      drawer: const Drawer(),
      body: HomePage(),
    );
  }
}
