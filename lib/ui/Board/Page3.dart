import 'package:flutter/material.dart';

class PostScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorteo Champions League'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/SorteoChampions.jpg',
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
                    'Sorteo de octavos de la Champions League: fecha, día y cuándo se sortea el cuadro definitivo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'La Champions League 2024/25, la primera con el nuevo formato, está llena de novedades. Mientras los aficionados del fútbol se terminan de acostumbrar, la competición sigue avanzando, y este mes de febrero se celebran los playoff previos a los octavos de final, que es otro de los cambios con respecto a ediciones pasadas.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Los ocho equipos que superen esta ronda de eliminatorias a doble partido acceden a los octavos de final, donde esperan los clubes clasificados entre la 1º y la 8º posición en la fase de liga. Como ya ocurriese en el playoff, será un sorteo con condicionantes, pues para decidir los cruces las parejas de clasificados del 1º al 8º (1º y 2º, 3º y 4º, 5º y 6º, 7º y 8º) se repartirán cada uno por un lado del cuadro y a cada equipo se le asignará uno de los ocho clasificados de una forma similar a la de un cuadro de tenis.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Fecha: ¿qué día es el sorteo de octavos de la Champions League?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'El sorteo de los octavos de final de la Champions League se celebrará el próximo viernes 21 de febrero en la Casa del Fútbol Europeo en Nyon (Suiza). En el acto se decidirán los cruces de octavos y el orden de los partidos en cuartos y semifinales, por lo que quedará establecido el cuadro definitivo.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/images/CalendarioChampions.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
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