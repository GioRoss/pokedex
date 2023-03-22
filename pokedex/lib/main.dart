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
  List<Map<String, dynamic>> _pages = [];

  int _selectedPagesIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
      },
      {
        'page': const ListaPokemon(),
      },
      {
        'page': const ListaPokemonTeam(),
      },
      {
        'page': const ListaPokemonFavoriti(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPagesIndex = index;
    });
  }

  BoxFit fitted(double width) {
    if (width < 550) {
      return BoxFit.cover;
    } else {
      return BoxFit.contain;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/pokemonLogo.png'),
                fit: fitted(width),
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawer(),
      body: _pages[_selectedPagesIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPagesIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.abc,
            ),
            label: 'Pokedex',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Squadra',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.stars,
            ),
            label: 'Preferiti',
          ),
        ],
      ),
    );
  }
}
