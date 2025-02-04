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
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Agregar Competencia"),
          content: TextField(controller: controller, decoration: InputDecoration(hintText: "Nombre")),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  dataProvider.addCompetencia(Competencia(nombre: controller.text, fechaInicio: DateTime.now(), fechaFin: DateTime.now().add(Duration(days: 30))));
                }
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _editarCompetencia(BuildContext context, DataProvider dataProvider, int index, Competencia competencia) {
    TextEditingController controller = TextEditingController(text: competencia.nombre);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Competencia"),
          content: TextField(controller: controller),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  dataProvider.updateCompetencia(index, Competencia(nombre: controller.text, fechaInicio: competencia.fechaInicio, fechaFin: competencia.fechaFin));
                }
                Navigator.pop(context);
              },
              child: Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }
}
