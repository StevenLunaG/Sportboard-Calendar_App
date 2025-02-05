import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/equipo.dart';
import '../../providers/data_provider.dart';

class EquiposTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          body: ListView.builder(
            itemCount: dataProvider.equipos.length,
            itemBuilder: (context, index) {
              final equipo = dataProvider.equipos[index];
              return ListTile(
                title: Text(equipo.nombre),
                onTap: () => _editarEquipo(context, dataProvider, equipo),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => dataProvider.deleteEquipo(index),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _agregarEquipo(context, dataProvider),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _agregarEquipo(BuildContext context, DataProvider dataProvider) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Agregar Equipo"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Nombre del equipo"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  dataProvider.addEquipo(Equipo(nombre: controller.text));
                  Navigator.pop(context);
                }
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _editarEquipo(BuildContext context, DataProvider dataProvider, Equipo equipo) {
    TextEditingController controller = TextEditingController(text: equipo.nombre);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Equipo"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Nombre del equipo"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  // Assuming you add an updateEquipo method to DataProvider
                  dataProvider.updateEquipo(
                    dataProvider.equipos.indexOf(equipo),
                    Equipo(nombre: controller.text),
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
  }
}
