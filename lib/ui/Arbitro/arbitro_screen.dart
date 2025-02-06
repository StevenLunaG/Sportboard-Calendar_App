import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/competencia.dart';
import '../../providers/data_provider.dart';
import 'competencia_detail_screen.dart';
import '../Management/manage_screen.dart';

class ArbitroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar...',
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Competencias',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataProvider.competencias.length,
                    itemBuilder: (context, index) {
                      final competencia = dataProvider.competencias[index];
                      return ListTile(
                        title: Text(competencia.nombre),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompetenciaDetailScreen(competencia: competencia),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManagementScreen()),
          );
        },
        child: Icon(Icons.more_horiz),
      ),
    );
  }
}