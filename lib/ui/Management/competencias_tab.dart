import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/competencia.dart';
import '../../providers/data_provider.dart';

class CompetenciasTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          body: ListView.builder(
            itemCount: dataProvider.competencias.length,
            itemBuilder: (context, index) {
              final competencia = dataProvider.competencias[index];
              return ListTile(
                title: Text(competencia.nombre),
                onTap: () => _editarCompetencia(context, dataProvider, index, competencia),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => dataProvider.deleteCompetencia(index),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _agregarCompetencia(context, dataProvider),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _agregarCompetencia(BuildContext context, DataProvider dataProvider) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController fechaInicioController = TextEditingController();
    TextEditingController fechaFinController = TextEditingController();
    DateTime? fechaInicio;
    DateTime? fechaFin;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Agregar Competencia"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(hintText: "Nombre"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaInicioController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha Inicio",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            fechaInicio = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (fechaInicio != null) {
                              setState(() {
                                fechaInicioController.text = "${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}";
                                if (fechaFin != null && fechaFin!.isBefore(fechaInicio!)) {
                                  fechaFin = null;
                                  fechaFinController.clear();
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaFinController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha Fin",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            fechaFin = await showDatePicker(
                              context: context,
                              initialDate: fechaInicio ?? DateTime.now(),
                              firstDate: fechaInicio ?? DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (fechaFin != null) {
                              setState(() {
                                fechaFinController.text = "${fechaFin!.day}/${fechaFin!.month}/${fechaFin!.year}";
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
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
                TextButton(
                  onPressed: () {
                    if (nombreController.text.isNotEmpty && fechaInicio != null && fechaFin != null) {
                      dataProvider.addCompetencia(Competencia(
                        nombre: nombreController.text,
                        fechaInicio: fechaInicio!,
                        fechaFin: fechaFin!,
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

  void _editarCompetencia(BuildContext context, DataProvider dataProvider, int index, Competencia competencia) {
    TextEditingController nombreController = TextEditingController(text: competencia.nombre);
    TextEditingController fechaInicioController = TextEditingController(text: "${competencia.fechaInicio.day}/${competencia.fechaInicio.month}/${competencia.fechaInicio.year}");
    TextEditingController fechaFinController = TextEditingController(text: "${competencia.fechaFin.day}/${competencia.fechaFin.month}/${competencia.fechaFin.year}");
    DateTime? fechaInicio = competencia.fechaInicio;
    DateTime? fechaFin = competencia.fechaFin;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Editar Competencia"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(hintText: "Nombre"),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaInicioController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha Inicio",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            fechaInicio = await showDatePicker(
                              context: context,
                              initialDate: competencia.fechaInicio,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (fechaInicio != null) {
                              setState(() {
                                fechaInicioController.text = "${fechaInicio!.day}/${fechaInicio!.month}/${fechaInicio!.year}";
                                if (fechaFin != null && fechaFin!.isBefore(fechaInicio!)) {
                                  fechaFin = null;
                                  fechaFinController.clear();
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: fechaFinController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha Fin",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            fechaFin = await showDatePicker(
                              context: context,
                              initialDate: competencia.fechaFin,
                              firstDate: fechaInicio ?? DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (fechaFin != null) {
                              setState(() {
                                fechaFinController.text = "${fechaFin!.day}/${fechaFin!.month}/${fechaFin!.year}";
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
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
                TextButton(
                  onPressed: () {
                    if (nombreController.text.isNotEmpty && fechaInicio != null && fechaFin != null) {
                      dataProvider.updateCompetencia(index, Competencia(
                        nombre: nombreController.text,
                        fechaInicio: fechaInicio!,
                        fechaFin: fechaFin!,
                      ));
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
