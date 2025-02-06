// partidos_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/partido.dart';
import '../../providers/data_provider.dart';

class PartidosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          body: ListView.builder(
            itemCount: dataProvider.partidos.length,
            itemBuilder: (context, index) {
              final partido = dataProvider.partidos[index];
              return ListTile(
                title: Text("${partido.equipoLocal} vs ${partido.equipoVisitante}"),
                subtitle: Text(
                    "Competencia: ${partido.competencia}\nFecha: ${_formatDate(partido.fecha)} - Hora: ${partido.hora.format(context)}\nEstado: ${partido.estado}\nMarcador: ${partido.marcadorLocal} - ${partido.marcadorVisitante}"),
                onTap: () => _editarPartido(context, dataProvider, partido),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => dataProvider.deletePartido(index),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _agregarPartido(context, dataProvider),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _agregarPartido(BuildContext context, DataProvider dataProvider) {
    String? selectedCompetencia;
    String? equipoLocal;
    String? equipoVisitante;
    DateTime? fecha;
    TimeOfDay? hora;
    TextEditingController fechaController = TextEditingController();
    TextEditingController horaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Agregar Partido"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedCompetencia,
                      items: dataProvider.competencias.map((c) {
                        return DropdownMenuItem(value: c.nombre, child: Text(c.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedCompetencia = value);
                      },
                      decoration: InputDecoration(labelText: "Seleccionar Competencia"),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: equipoLocal,
                      items: dataProvider.equipos.map((e) {
                        return DropdownMenuItem(value: e.nombre, child: Text(e.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => equipoLocal = value);
                      },
                      decoration: InputDecoration(labelText: "Equipo Local"),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: equipoVisitante,
                      items: dataProvider.equipos
                          .where((e) => e.nombre != equipoLocal)  // Filtrar equipo local
                          .map((e) {
                        return DropdownMenuItem(value: e.nombre, child: Text(e.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => equipoVisitante = value);
                      },
                      decoration: InputDecoration(labelText: "Equipo Visitante"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_month),
                          onPressed: () async {
                            fecha = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (fecha != null) {
                              setState(() {
                                fechaController.text = _formatDate(fecha!);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: horaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Hora",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            hora = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (hora != null) {
                              setState(() {
                                horaController.text = hora!.format(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedCompetencia != null &&
                        equipoLocal != null &&
                        equipoVisitante != null &&
                        fecha != null &&
                        hora != null) {
                      dataProvider.addPartido(Partido(
                        competencia: selectedCompetencia!,
                        equipoLocal: equipoLocal!,
                        equipoVisitante: equipoVisitante!,
                        fecha: fecha!,
                        hora: hora!,
                        estado: Estado.PENDIENTE,
                        marcadorLocal: 0,
                        marcadorVisitante: 0,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Guardar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editarPartido(BuildContext context, DataProvider dataProvider, Partido partido) {
    String? selectedCompetencia = partido.competencia;
    String? equipoLocal = partido.equipoLocal;
    String? equipoVisitante = partido.equipoVisitante;
    DateTime? fecha = partido.fecha;
    TimeOfDay? hora = partido.hora;
    TextEditingController fechaController = TextEditingController(
      text: _formatDate(partido.fecha),
    );
    TextEditingController horaController = TextEditingController(
      text: partido.hora.format(context),
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Editar Partido"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedCompetencia,
                      items: dataProvider.competencias.map((c) {
                        return DropdownMenuItem(value: c.nombre, child: Text(c.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedCompetencia = value);
                      },
                      decoration: InputDecoration(labelText: "Seleccionar Competencia"),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: equipoLocal,
                      items: dataProvider.equipos.map((e) {
                        return DropdownMenuItem(value: e.nombre, child: Text(e.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          equipoLocal = value;
                          // Si el equipo visitante es igual al nuevo equipo local, lo reseteamos
                          if (equipoVisitante == value) {
                            equipoVisitante = null;
                          }
                        });
                      },
                      decoration: InputDecoration(labelText: "Equipo Local"),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: equipoVisitante,
                      items: dataProvider.equipos
                          .where((e) => e.nombre != equipoLocal)  // Filtrar equipo local
                          .map((e) {
                        return DropdownMenuItem(value: e.nombre, child: Text(e.nombre));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => equipoVisitante = value);
                      },
                      decoration: InputDecoration(labelText: "Equipo Visitante"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_month),
                          onPressed: () async {
                            fecha = await showDatePicker(
                              context: context,
                              initialDate: partido.fecha,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (fecha != null) {
                              setState(() {
                                fechaController.text = _formatDate(fecha!);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: horaController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Hora",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            hora = await showTimePicker(
                              context: context,
                              initialTime: partido.hora,
                            );
                            if (hora != null) {
                              setState(() {
                                horaController.text = hora!.format(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedCompetencia != null &&
                        equipoLocal != null &&
                        equipoVisitante != null &&
                        fecha != null &&
                        hora != null) {
                      dataProvider.updatePartido(
                        dataProvider.partidos.indexOf(partido),
                        Partido(
                          competencia: selectedCompetencia!,
                          equipoLocal: equipoLocal!,
                          equipoVisitante: equipoVisitante!,
                          fecha: fecha!,
                          hora: hora!,
                          estado: partido.estado,
                          marcadorLocal: partido.marcadorLocal,
                          marcadorVisitante: partido.marcadorVisitante,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Actualizar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}