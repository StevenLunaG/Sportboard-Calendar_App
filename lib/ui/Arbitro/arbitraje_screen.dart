import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/partido.dart';
import '../../models/evento.dart';
import '../../models/solicitudReprogramacion.dart';
import '../../providers/data_provider.dart';
import 'competencia_detail_screen.dart';
import 'event_dialog.dart';
import 'reprogramacion_dialog.dart';
import 'package:flutter/services.dart';

//Si
class ArbitrajeScreen extends StatefulWidget {
  final Partido partido;

  ArbitrajeScreen({required this.partido});

  @override
  _ArbitrajeScreenState createState() => _ArbitrajeScreenState();
}

class _ArbitrajeScreenState extends State<ArbitrajeScreen> {
  int marcadorLocal = 0;
  int marcadorVisitante = 0;
  bool _reprogramacionExists = false;

  @override
  @override
  void initState() {
    super.initState();
    marcadorLocal = widget.partido.marcadorLocal;
    marcadorVisitante = widget.partido.marcadorVisitante;
    _checkReprogramacionExists();
  }

  void _checkReprogramacionExists() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    setState(() {
      _reprogramacionExists = dataProvider.reprogramaciones.any((reprogramacion) => reprogramacion.partido == widget.partido.competencia);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.partido.equipoLocal} vs ${widget.partido.equipoVisitante}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Marcador', style: Theme.of(context).textTheme.titleMedium),
            Divider(),
            _buildMarcador(context),
            SizedBox(height: 16),
            Text('Eventos', style: Theme.of(context).textTheme.titleMedium),
            Divider(),
            Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () => _showEventDialog(context, null),
                  icon: Icon(Icons.add),
                  label: Text('Registrar evento'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(child: _buildEventList(context)),
            SizedBox(height: 16),
            Text('Reprogramación', style: Theme.of(context).textTheme.titleMedium),
            Divider(),
            Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: _reprogramacionExists ? null : () => _showReprogramacionDialog(context, null),
                  child: Text('Registrar solicitud de reprogramación'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(child: _buildReprogramacionList(context)),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => _confirmarTerminarArbitraje(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF502C94), // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Increase size
                ),
                child: Text('Terminar arbitraje'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarcador(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(widget.partido.equipoLocal, style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: marcadorLocal > 0
                          ? () {
                        setState(() {
                          marcadorLocal--;
                          widget.partido.updateMarcadorLocal(marcadorLocal);
                          Provider.of<DataProvider>(context, listen: false).updatePartido(
                            Provider.of<DataProvider>(context, listen: false).partidos.indexOf(widget.partido),
                            widget.partido,
                          );
                        });
                      }
                          : null,
                    ),
                    Text(
                      marcadorLocal.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          marcadorLocal++;
                          widget.partido.updateMarcadorLocal(marcadorLocal);
                          Provider.of<DataProvider>(context, listen: false).updatePartido(
                            Provider.of<DataProvider>(context, listen: false).partidos.indexOf(widget.partido),
                            widget.partido,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text('vs', style: Theme.of(context).textTheme.headlineSmall),
            Column(
              children: [
                Text(widget.partido.equipoVisitante, style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: marcadorVisitante > 0
                          ? () {
                        setState(() {
                          marcadorVisitante--;
                          widget.partido.updateMarcadorVisitante(marcadorVisitante);
                          Provider.of<DataProvider>(context, listen: false).updatePartido(
                            Provider.of<DataProvider>(context, listen: false).partidos.indexOf(widget.partido),
                            widget.partido,
                          );
                        });
                      }
                          : null,
                    ),
                    Text(
                      marcadorVisitante.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          marcadorVisitante++;
                          widget.partido.updateMarcadorVisitante(marcadorVisitante);
                          Provider.of<DataProvider>(context, listen: false).updatePartido(
                            Provider.of<DataProvider>(context, listen: false).partidos.indexOf(widget.partido),
                            widget.partido,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildEventList(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final eventos = dataProvider.eventos.where((evento) => evento.partido == widget.partido.competencia).toList();
        return ListView.builder(
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            final evento = eventos[index];
            return ListTile(
              title: Text(evento.tipo.toString().split('.').last),
              subtitle: Text(evento.tiempo.format(context)),
              onTap: () => _showEventDialog(context, evento),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => dataProvider.deleteEvento(index),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReprogramacionList(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final reprogramaciones = dataProvider.reprogramaciones.where((reprogramacion) => reprogramacion.partido == widget.partido.competencia).toList();
        return ListView.builder(
          itemCount: reprogramaciones.length,
          itemBuilder: (context, index) {
            final reprogramacion = reprogramaciones[index];
            return ListTile(
              title: Text("${reprogramacion.fecha.day}/${reprogramacion.fecha.month}/${reprogramacion.fecha.year} ${reprogramacion.hora.format(context)}"),
              onTap: () => _showReprogramacionDialog(context, reprogramacion),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dataProvider.deleteReprogramacion(index);
                  _checkReprogramacionExists();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showEventDialog(BuildContext context, Evento? evento) {
    showDialog(
      context: context,
      builder: (context) {
        return EventDialog(partido: widget.partido, evento: evento);
      },
    );
  }

  void _showReprogramacionDialog(BuildContext context, Reprogramacion? reprogramacion) {
    showDialog(
      context: context,
      builder: (context) {
        return ReprogramacionDialog(partido: widget.partido, reprogramacion: reprogramacion);
      },
    ).then((_) => _checkReprogramacionExists());
  }

  void _confirmarTerminarArbitraje(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text("Una vez termines el arbitraje ya no podrás actualizar sus resultados. ¿Desea continuar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                final dataProvider = Provider.of<DataProvider>(context, listen: false);
                dataProvider.updatePartido(
                  dataProvider.partidos.indexOf(widget.partido),
                  Partido(
                    competencia: widget.partido.competencia,
                    fecha: widget.partido.fecha,
                    hora: widget.partido.hora,
                    equipoLocal: widget.partido.equipoLocal,
                    equipoVisitante: widget.partido.equipoVisitante,
                    estado: Estado.TERMINADO,
                    marcadorLocal: widget.partido.marcadorLocal,
                    marcadorVisitante: widget.partido.marcadorVisitante,
                  ),
                );
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompetenciaDetailScreen(competencia: dataProvider.competencias.firstWhere((comp) => comp.nombre == widget.partido.competencia)),
                  ),
                );
              },
              child: Text("Continuar"),
            ),
          ],
        );
      },
    );
  }
}