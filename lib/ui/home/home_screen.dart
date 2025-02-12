import 'package:first/ui/Board/Page1.dart';
import 'package:first/ui/Board/Page2.dart';
import 'package:first/ui/Board/Page3.dart';
import 'package:first/ui/Board/Page4.dart';

import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              // Lista de imágenes para cada box
              List<String> images = [
                'assets/images/aso.jpg',
                'assets/images/CopaDelRey.jpg',
                'assets/images/Champions.jpeg',
                'assets/images/CopaEuropaLeague.jpg',
              ];

              // Lista de páginas de destino
              List<Widget> pages = [
                PostScreen1(),
                PostScreen2(),
                PostScreen3(),
                PostScreen4(),
              ];

              // Lista de títulos para cada box
              List<String> titles = [
                'Campeonato Computación 2025',
                'Copa del Rey',
                'Champions League',
                'Europa League',
              ];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pages[index]),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            titles[index], // Asigna el título correspondiente
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}