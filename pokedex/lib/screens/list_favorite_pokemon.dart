import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokedex.dart';
import 'package:provider/provider.dart';

import '../provider/pokemon.dart';
import 'scheda_pokemon.dart';

class ListaPokemonFavoriti extends StatefulWidget {
  const ListaPokemonFavoriti({super.key});
  static const routeName = '/lista-favoriti';

  @override
  State<ListaPokemonFavoriti> createState() => _ListaPokemonFavoritiState();
}

class _ListaPokemonFavoritiState extends State<ListaPokemonFavoriti> {
  @override
  Widget build(BuildContext context) {
    final favoriti = Provider.of<Pokedex>(context);
    final List<Pokemon> listaFavoriti = favoriti.favoritePokemon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Favoriti'),
      ),
      body: ListView.builder(
        itemCount: listaFavoriti.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              elevation: 5,
              child: SizedBox(
                height: 65,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor:
                      favoriti.getPokemonTypeColor(listaFavoriti[index].tipo),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '#0${listaFavoriti[index].id} ${favoriti.capitalize(listaFavoriti[index].nome)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Wrap(
                    spacing: 5,
                    children: <Widget>[
                      ...favoriti.getPokemonType(listaFavoriti[index].tipo),
                    ],
                  ),
                  trailing: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('../../assets/images/pokeball.png'),
                      ),
                    ),
                    child: Image.network(
                      listaFavoriti[index].imgIcona,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: listaFavoriti[index],
                          child: SchedaPokemon(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
