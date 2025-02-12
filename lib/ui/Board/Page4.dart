import 'package:flutter/material.dart';

class PostScreen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorteo Europa League'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/SorteoEuropaLeague.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fecha: 12/02/2025',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sorteo de los play-offs eliminatorios de la UEFA Europa League',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'El sorteo de los play-offs eliminatorios de la UEFA Europa League 2024/25 tuvo lugar el 31 de enero.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Cruces de la fase de play-offs eliminatorios de la Europa League',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'El sorteo de los play-offs eliminatorios de la UEFA Europa League 2024/25 tuvo lugar el 31 de enero.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/images/CalendarioEuropaLeague.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '¿Qué es la fase de play-offs eliminatorios de la Europa League?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Mientras que los ocho primeros clasificados de la fase liga se clasifican automáticamente para los octavos de final, los equipos que terminan entre los puestos noveno y vigésimo cuarto inician la fase eliminatoria. Estos equipos disputarán unos play-offs a doble partido para asegurarse el pase a octavos de final.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A partir de la fase de los play-offs eliminatorios, el torneo se divide en un cuadro. Los equipos que terminaron la fase de liga entre los puestos 9º y 16º fueron cabezas de serie en el primer sorteo de la fase eliminatoria y se enfrentarán a un equipo situado entre los puestos 17º y 24º. En principio, el cabeza de serie jugará el partido de vuelta en casa.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Los posibles rivales también estuvieron predefinidos por los emparejamientos de las posiciones finales de los equipos en la fase liga. Por ejemplo, los equipos que terminaron noveno y décimo se enfrentarían a los equipos que acabaron 23º o 24º; los equipos que terminasen 11º o 12º se enfrentarían a los equipos que terminasen 21º o 22º, y así sucesivamente.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Los ocho equipos que se impongan en la fase de los play-offs eliminatorios pasarán a octavos de final.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}