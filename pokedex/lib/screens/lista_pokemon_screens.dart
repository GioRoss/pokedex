import 'package:flutter/material.dart';
import '../provider/api.dart' as api;

class ListaPokemon extends StatefulWidget {
  static const routeName = '/lista-pokemon';

  @override
  State<ListaPokemon> createState() => _ListaPokemonState();
}

class _ListaPokemonState extends State<ListaPokemon> {
  List<dynamic> pokemon = [];

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      final List<dynamic> listPokemon = await api.fetchPokemon();
      setState(() {
        pokemon = listPokemon;
      });
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('LISTA POKEMON'),
    )
        // body: GridView.builder(
        //     gridDelegate: ,
        //     itemCount: pokemon.length, itemBuilder: (ctx, index){
        //       return Container();
        //     })
        );
  }
}
