import 'package:flutter/material.dart';

class PostScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compeonato Computacion 2025'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/1.png',
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
                    'Las competencias deportivas de computación han culminado',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Las competencias deportivas entre los diferentes ciclos de la carrera de computación han culminado. Los estudiantes de los diferentes ciclos han demostrado sus habilidades en las diferentes disciplinas deportivas. Los ganadores de las competencias han sido premiados con medallas y trofeos. Los estudiantes han disfrutado de un día lleno de diversión y emoción.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Resultados de las competencias:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/images/Competencia1.png',
                    width: double.infinity,
                    height: 700,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/images/Competencia2.png',
                    width: double.infinity,
                    height: 400,
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