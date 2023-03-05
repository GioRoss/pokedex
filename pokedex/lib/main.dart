// import 'package:animalcrossingpedia/provider/api.dart';
import 'package:flutter/material.dart';
import 'provider/api.dart' as api;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.amber,
            secondary: Colors.red.shade600,
            tertiary: Colors.brown.shade300),
      ),
      home: PokemonApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PokemonApp extends StatefulWidget {
  @override
  _PokemonApp createState() => _PokemonApp();
}

class _PokemonApp extends State<PokemonApp> {
  List<dynamic> pokemon = [];

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    // try-catch per l'ottenimento delle carte dalla chiamata api
    try {
      final List<dynamic> listPokemon = await api.fetchPokemon();
      setState(() {
        pokemon = listPokemon;
      });
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon'),
      ),
      body: Container(
        color: Colors.amber,
        child: ListView.builder(
          itemCount: pokemon.length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                Image.network(
                  pokemon[i]['img_icona'],
                ),
                Image.network(
                  pokemon[i]['img_profilo'],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
