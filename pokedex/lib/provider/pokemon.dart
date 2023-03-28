import 'package:flutter/material.dart';

class Pokemon with ChangeNotifier {
  final String nome;
  final List<dynamic> tipo;
  final int id;
  final String imgProfilo;
  final String imgIcona;

  final int esperienzaBase;
  final List<dynamic> abilita;
  final int altezza;
  final List<dynamic> mosse;
  final int peso;
  bool isFavorite;
  bool isTeam;

  Pokemon({
    required this.nome,
    required this.esperienzaBase,
    required this.abilita,
    required this.altezza,
    required this.id,
    required this.mosse,
    required this.imgIcona,
    required this.imgProfilo,
    required this.tipo,
    required this.peso,
    required this.isFavorite,
    required this.isTeam,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        esperienzaBase = json['esperienza'],
        abilita = json['abilita'],
        altezza = json['altezza'],
        id = json['id'],
        mosse = json['mosse'],
        imgIcona = json['immagineIcona'],
        imgProfilo = json['immagineProfilo'],
        tipo = json['tipo'],
        peso = json['peso'],
        isFavorite = json['favorito'],
        isTeam = json['delTeam'];

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'esperienza': esperienzaBase,
      'abilita': abilita,
      'altezza': altezza,
      'id': id,
      'mosse': mosse,
      'immagineIcona': imgIcona,
      'immagineProfilo': imgProfilo,
      'tipo': tipo,
      'peso': peso,
      'favorito': isFavorite,
      'delTeam': isTeam,
    };
  }
}
