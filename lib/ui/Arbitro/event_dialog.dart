import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/evento.dart';
import '../../models/partido.dart';
import '../../providers/data_provider.dart';

class EventDialog extends StatefulWidget {
  final Partido partido;
  final Evento? evento;

  EventDialog({required this.partido, this.evento});

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _descripcion;
  late Tipo _tipo;
  late TimeOfDay _tiempo;

  @override
  void initState() {
    super.initState();
    if (widget.evento != null) {
      _descripcion = widget.evento!.descripcion;
      _tipo = widget.evento!.tipo;
      _tiempo = widget.evento!.tiempo;
    } else {
      _descripcion = '';
      _tipo = Tipo.GOL;
      _tiempo = TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.evento == null ? 'Registrar Evento' : 'Editar Evento'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Tipo>(
                value: _tipo,
                items: Tipo.values.map((tipo) {
                  return DropdownMenuItem(value: tipo, child: Text(tipo.toString().split('.').last));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _tipo = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Tipo de Evento'),
              ),
              TextFormField(
                initialValue: _descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descripcion = value!;
                },
                minLines: 1,
                maxLines: null,
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tiempo',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _tiempo,
                      );
                      if (time != null) {
                        setState(() {
                          _tiempo = time;
                        });
                      }
                    },
                  ),
                ),
                controller: TextEditingController(text: _tiempo.format(context)),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final dataProvider = Provider.of<DataProvider>(context, listen: false);
              if (widget.evento == null) {
                dataProvider.addEvento(Evento(
                  partido: widget.partido.competencia,
                  descripcion: _descripcion,
                  tipo: _tipo,
                  tiempo: _tiempo,
                ));
              } else {
                dataProvider.updateEvento(
                  dataProvider.eventos.indexOf(widget.evento!),
                  Evento(
                    partido: widget.partido.competencia,
                    descripcion: _descripcion,
                    tipo: _tipo,
                    tiempo: _tiempo,
                  ),
                );
              }
              Navigator.pop(context);
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}