import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokedex.dart';

class InfoSchedaPokemonLista extends StatelessWidget {
  double width;
  List<dynamic> pokemonListInfo;
  Pokedex pokemonData;
  String etichetta;

  InfoSchedaPokemonLista(
      {required this.width,
      required this.pokemonListInfo,
      required this.pokemonData,
      required this.etichetta});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.45,
            child: Text(
              etichetta,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: width > 1200
                    ? 22
                    : width < 310
                        ? 13
                        : 17,
              ),
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...pokemonListInfo
                    .map(
                      (abilita) => Text(
                        pokemonData.capitalize(abilita).toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width > 1200
                              ? 22
                              : width < 310
                                  ? 13
                                  : 17,
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
