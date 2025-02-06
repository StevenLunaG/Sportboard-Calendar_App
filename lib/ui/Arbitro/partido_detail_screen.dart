import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/partido.dart';
import '../../models/evento.dart';
import '../../models/solicitudReprogramacion.dart';
import '../../providers/data_provider.dart';

class PartidoDetailScreen extends StatefulWidget {
  final Partido partido;

  PartidoDetailScreen({required this.partido});

  @override
  _PartidoDetailScreenState createState() => _PartidoDetailScreenState();
}

class _PartidoDetailScreenState extends State<PartidoDetailScreen> {
  int marcadorLocal = 0;
  int marcadorVisitante = 0;
  bool _reprogramacionExists = false;

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
            Expanded(child: _buildEventList(context)),
            SizedBox(height: 16),
            Text('Reprogramación', style: Theme.of(context).textTheme.titleMedium),
            Divider(),
            Expanded(child: _buildReprogramacionList(context)),
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
                Text(
                  marcadorLocal.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            Text('vs', style: Theme.of(context).textTheme.headlineSmall),
            Column(
              children: [
                Text(widget.partido.equipoVisitante, style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 8),
                Text(
                  marcadorVisitante.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
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
            );
          },
        );
      },
    );
  }
}