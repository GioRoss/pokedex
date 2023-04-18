import 'package:flutter/material.dart';
import 'package:pokedex/widgets/info_scheda_pokemon.dart';
import 'package:pokedex/widgets/info_scheda_pokemon_list.dart';
import 'package:provider/provider.dart';
import '../provider/pokedex.dart';
import '../provider/pokemon.dart';

class SchedaPokemon extends StatefulWidget {
  static const routeName = '/scheda-pokemon';

  const SchedaPokemon({super.key});
  @override
  State<SchedaPokemon> createState() => _SchedaPokemonState();
}

class _SchedaPokemonState extends State<SchedaPokemon> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pokemonData = Provider.of<Pokedex>(context);
    final pokemon = Provider.of<Pokemon>(context);

    final pokemonNome = pokemon.nome.toUpperCase();
    final pokemonTipo = pokemon.tipo;
    final pokemonColore = pokemonData.getPokemonTypeColor(pokemon.tipo);
    final pokemonId = pokemon.id;
    final pokemonImg = pokemon.imgProfilo;
    final pokemonEsperienza = pokemon.esperienzaBase;
    final pokemonAbilita = pokemon.abilita;
    final pokemonAltezza = pokemon.altezza;
    final pokemonMosse = pokemon.mosse;
    final pokemonPeso = pokemon.peso;

    return Scaffold(
      backgroundColor: pokemonColore,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: width > 1200 ? 1 : 3,
              left: 9,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Colors.white,
                  size: width > 1200 ? 45 : 40,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              top: width > 1200 ? 55 : 60,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemonNome,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width > 1200
                          ? 40
                          : width < 310
                              ? 20
                              : 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "#$pokemonId",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width > 1200
                          ? 40
                          : width < 310
                              ? 20
                              : 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 105,
              left: 22,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 5,
                children: [
                  ...pokemonData.getPokemonType(
                      pokemonTipo, width > 310 ? width : width / 3),
                ],
              ),
            ),
            Positioned(
              bottom: (height / 2) + 10,
              right: -30,
              child: Image.asset(
                'assets/images/pokeball.png',
                height: width > 1200
                    ? 250
                    : width < 400
                        ? 150
                        : 200,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.53,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        InfoSchedaPokemon(
                          width: width,
                          etichetta: 'Nome: ',
                          descrizione: pokemonNome,
                        ),
                        InfoSchedaPokemon(
                          width: width,
                          etichetta: 'Altezza: ',
                          descrizione: '${pokemonAltezza.toString()}.0 cm',
                        ),
                        InfoSchedaPokemon(
                          width: width,
                          etichetta: 'Peso: ',
                          descrizione: '${pokemonPeso.toString()}.0 gr',
                        ),
                        InfoSchedaPokemonLista(
                          width: width,
                          pokemonListInfo: pokemonAbilita,
                          pokemonData: pokemonData,
                          etichetta: 'Abilità: ',
                        ),
                        InfoSchedaPokemonLista(
                          width: width,
                          pokemonListInfo: pokemonMosse,
                          pokemonData: pokemonData,
                          etichetta: 'Mosse: ',
                        ),
                        InfoSchedaPokemon(
                          width: width,
                          etichetta: 'Esperienza Iniziale: ',
                          descrizione: pokemonEsperienza.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: (height / 2) - 5,
              left: width < 350 ? width / 3 : (width / 2) - 10,
              child: Image.network(
                pokemonImg,
                height: width > 1200
                    ? 250
                    : width < 450
                        ? 150
                        : 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
