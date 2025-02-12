import 'package:flutter/material.dart';

class PostScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorteo Copa Del Rey'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/SorteoCopaRey.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
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
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ya se conocen los horarios de las semifinales de la Copa del Rey',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'La Real Federación Española de Fútbol ha celebrado este miércoles el sorteo de las semifinales de la Copa del Rey en el salón de actos Luis Aragonés, en Las Rozas. ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Los emparejamientos han deparado dos duelos de alto calibre: el FC Barcelona se medirá al Atlético de Madrid, mientras que la Real Sociedad hará lo propio frente al Real Madrid.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Calendario de semifinales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Partidos de ida:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('📅 25 de febrero: FC Barcelona - Atlético de Madrid (21:30 h)'),
                  Text('📅 26 de febrero: Real Sociedad - Real Madrid (21:30 h)'),
                  SizedBox(height: 12),
                  Text(
                    'Partidos de vuelta:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('📅 1 de abril: Real Madrid - Real Sociedad (21:30 h)'),
                  Text('📅 2 de abril: Atlético de Madrid - FC Barcelona (21:30 h)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
