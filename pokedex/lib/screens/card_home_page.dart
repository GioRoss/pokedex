import 'package:flutter/material.dart';

class CardHomePage extends StatelessWidget {
  final Color colore1;
  final Color colore2;
  final String rotta;
  final String testo;
  final IconData icona;
  final Color? coloreIcona;

  CardHomePage(
      {required this.colore1,
      required this.colore2,
      required this.rotta,
      required this.testo,
      required this.icona,
      this.coloreIcona});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: colore1,
      borderRadius: BorderRadius.circular(15),
      onTap: () => Navigator.of(context).pushNamed(rotta),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colore1.withOpacity(0.7), colore1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              testo.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              icona,
              color: coloreIcona,
            ),
          ],
        ),
      ),
    );
  }
}
