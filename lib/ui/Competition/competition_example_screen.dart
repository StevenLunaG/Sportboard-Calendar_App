import 'package:flutter/material.dart';

class CompetitionExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la Competencia'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/1.png'), // Cover image at the top
              SizedBox(height: 10),
              Text(
                'Nombre: Campeonato Computacion 2025',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Fecha de inicio: 01/01/2025',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Fecha de fin: 31/12/2025',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Disciplina: Futbol',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Equipos Participantes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    leading: Icon(Icons.sports_soccer),
                    title: Text('Equipo 1'),
                  ),
                  ListTile(
                    leading: Icon(Icons.sports_soccer),
                    title: Text('Equipo 2'),
                  ),
                  ListTile(
                    leading: Icon(Icons.sports_soccer),
                    title: Text('Equipo 3'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Ejemplo de Contenido:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: Text('Canvas de Ejemplo'),
                ),
              ),
              SizedBox(height: 10),
              Image.network('https://via.placeholder.com/150'),
              SizedBox(height: 10),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Equipo'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Puntos'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Equipo 1'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('10'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Equipo 2'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('8'),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}