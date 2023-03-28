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
    final team = Provider.of<Pokedex>(context);
    final teamFalse = Provider.of<Pokedex>(context, listen: false);
    final List<Pokemon> listaTeam = team.teamPokemon;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('TEAM'),
            Image.asset(
              '../../assets/images/pikachu.png',
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: listaTeam.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Sei Sicuro?'),
                  content:
                      const Text('Vuoi rimuovere il pokemon dalla squadra?'),
                  actions: <Widget>[
                    FloatingActionButton(
                      child: const Text('NO'),
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                    FloatingActionButton(
                      child: const Text('SI'),
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              teamFalse.toggleTeamStatus(
                listaTeam[index].id,
              );
              print('cambiato status');
              teamFalse.removePokemonTeam(listaTeam[index].id);
              print('rimosso');
              print(teamFalse.teamPokemon);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 65,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: team.getPokemonTypeColor(listaTeam[index].tipo),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        '#0${listaTeam[index].id} ${team.capitalize(listaTeam[index].nome)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        ...team.getPokemonType(listaTeam[index].tipo, 0),
                      ],
                    ),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/pokeball.png',
                          ),
                        ),
                      ),
                      child: Image.network(
                        listaTeam[index].imgIcona,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: listaTeam[index],
                            child: SchedaPokemon(),
                          );
                        },
                      ),
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
