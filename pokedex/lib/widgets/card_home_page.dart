import 'package:flutter/material.dart';

class CardHomePage extends StatelessWidget {
  final Color colore1;
  final Color colore2;
  final String rotta;
  final String testo;
  final IconData? icona;
  final String immagine;
  final Color? coloreIcona;

  const CardHomePage(
      {super.key,
      required this.colore1,
      required this.colore2,
      required this.rotta,
      required this.testo,
      this.icona,
      this.immagine = "",
      this.coloreIcona});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width > 1140 ? 29 : 17.5,
              ),
            ),
            immagine == ""
                ? Icon(
                    icona,
                    color: coloreIcona,
                    size: width > 1140 ? 45 : 30,
                  )
                : Image(
                    image: AssetImage(immagine),
                    height: width > 1140 ? 34 : 25,
                    width: width > 1140 ? 34 : 25,
                  )
          ],
        ),
      ),
    );
  }
}
