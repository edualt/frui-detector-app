import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> fruits = ['Pepino', 'Manzana', 'Platano', 'Guineo', 'Pera', 'Limon', 'Limon Mandarina', 'Mandarina', 'Tomate', 'Mango'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'NNFruit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          const Text(
            'Frutas disponibles:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          // Utilizando un ListView.builder para mostrar las frutas
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fruits.length,
            itemBuilder: (BuildContext context, int index) {
              // Para cada elemento en la lista de frutas, crea un widget Row con la imagen y el texto
              return Row(
                children: <Widget>[
                  // Imagen a la izquierda
                  Container(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/fruits/${fruits[index].toLowerCase()}.png", // Ruta de la imagen
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Texto a la derecha
                  Text(
                    fruits[index], // Nombre de la fruta
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
