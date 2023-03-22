import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokedex.dart';
import 'package:provider/provider.dart';

import '../provider/pokemon.dart';
import 'scheda_pokemon.dart';

class ListaPokemonTeam extends StatefulWidget {
  const ListaPokemonTeam({super.key});
  static const routeName = '/lista-team';

  @override
  State<ListaPokemonTeam> createState() => _ListaPokemonTeamState();
}

class _ListaPokemonTeamState extends State<ListaPokemonTeam> {
  @override
  Widget build(BuildContext context) {
    final favoriti = Provider.of<Pokedex>(context);
    final List<Pokemon> listaFavoriti = favoriti.pokemonMyTeam;
    double scaleFactor = 1.0;
    final width = MediaQuery.of(context).size.width * scaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Squadra'),
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
                      ...favoriti.getPokemonType(listaFavoriti[index].tipo, 0),
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
