import 'package:flutter/material.dart';

class Pokemon with ChangeNotifier {
  final String nome;
  final List<dynamic> tipo;
  final int id;
  final String imgProfilo;
  final String imgIcona;
  final String imgIconaShiny;
  final String imgProfiloShiny;
  final int esperienzaBase;
  final List<dynamic> abilita;
  final int altezza;
  final List<dynamic> mosse;
  final int peso;
  bool isFavorite;

  Pokemon({
    required this.nome,
    required this.esperienzaBase,
    required this.abilita,
    required this.altezza,
    required this.id,
    required this.mosse,
    required this.imgIcona,
    required this.imgIconaShiny,
    required this.imgProfilo,
    required this.imgProfiloShiny,
    required this.tipo,
    required this.peso,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
