import 'package:flutter/material.dart';

class InfoSchedaPokemon extends StatelessWidget {
  double width;
  String etichetta;
  String descrizione;

  InfoSchedaPokemon(
      {super.key,
      required this.width,
      required this.etichetta,
      required this.descrizione});

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
                fontSize: width > 1200 ? 22 : 17,
              ),
            ),
          ),
          SizedBox(
            child: Text(
              descrizione,
              style: TextStyle(
                color: Colors.black,
                fontSize: width > 1200 ? 22 : 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
