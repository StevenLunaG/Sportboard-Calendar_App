// lib/ui/Arbitro/competencia_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/competencia.dart';
import '../../models/partido.dart';
import '../../providers/data_provider.dart';
import 'arbitraje_screen.dart';
import 'partido_detail_screen.dart';

class CompetenciaDetailScreen extends StatelessWidget {
  final Competencia competencia;

  CompetenciaDetailScreen({required this.competencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(competencia.nombre),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          final partidos = dataProvider.partidos
              .where((partido) => partido.competencia == competencia.nombre)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Partidos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: partidos.length,
                    itemBuilder: (context, index) {
                      final partido = partidos[index];
                      return ListTile(
                        title: Text("${partido.equipoLocal} vs ${partido.equipoVisitante}"),
                        subtitle: Text(
                            "Fecha: ${_formatDate(partido.fecha)} - Hora: ${partido.hora.format(context)}\nMarcador: ${partido.marcadorLocal} - ${partido.marcadorVisitante}"),
                        onTap: () {
                          if (partido.estado == Estado.PENDIENTE) {
                            _showConfirmationDialog(context, dataProvider, partido);
                          } else if (partido.estado == Estado.EN_JUEGO) {
                            _navigateToArbitrajeScreen(context, partido);
                          } else if (partido.estado == Estado.TERMINADO) {
                            _navigateToPartidoDetailScreen(context, partido);
                          }
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
    );
  }

  void _showConfirmationDialog(BuildContext context, DataProvider dataProvider, Partido partido) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("Una vez empieces un partido su estado cambiará a \"En Juego\". ¿Continuar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                dataProvider.updatePartido(
                  dataProvider.partidos.indexOf(partido),
                  Partido(
                    competencia: partido.competencia,
                    fecha: partido.fecha,
                    hora: partido.hora,
                    equipoLocal: partido.equipoLocal,
                    equipoVisitante: partido.equipoVisitante,
                    estado: Estado.EN_JUEGO,
                    marcadorLocal: partido.marcadorLocal,
                    marcadorVisitante: partido.marcadorVisitante,
                  ),
                );
                Navigator.pop(context);
                _navigateToArbitrajeScreen(context, partido);
              },
              child: Text("Continuar"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToArbitrajeScreen(BuildContext context, Partido partido) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArbitrajeScreen(partido: partido),
      ),
    );
  }

  void _navigateToPartidoDetailScreen(BuildContext context, Partido partido) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartidoDetailScreen(partido: partido),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}