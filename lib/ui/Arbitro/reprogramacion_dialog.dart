import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/solicitudReprogramacion.dart';
import '../../models/partido.dart';
import '../../providers/data_provider.dart';

class ReprogramacionDialog extends StatefulWidget {
  final Partido partido;
  final Reprogramacion? reprogramacion;

  ReprogramacionDialog({required this.partido, this.reprogramacion});

  @override
  _ReprogramacionDialogState createState() => _ReprogramacionDialogState();
}

class _ReprogramacionDialogState extends State<ReprogramacionDialog> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _fecha;
  late TimeOfDay _hora;
  late String _descripcion;

  @override
  void initState() {
    super.initState();
    if (widget.reprogramacion != null) {
      _fecha = widget.reprogramacion!.fecha;
      _hora = widget.reprogramacion!.hora;
      _descripcion = widget.reprogramacion!.descripcion;
    } else {
      _fecha = DateTime.now();
      _hora = TimeOfDay.now();
      _descripcion = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.reprogramacion == null
          ? 'Registrar Solicitud de Reprogramación'
          : 'Editar Solicitud de Reprogramación'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _fecha,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (date != null) {
                        setState(() {
                          _fecha = date;
                        });
                      }
                    },
                  ),
                ),
                controller: TextEditingController(
                    text: "${_fecha.day}/${_fecha.month}/${_fecha.year}"),
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Hora',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _hora,
                      );
                      if (time != null) {
                        setState(() {
                          _hora = time;
                        });
                      }
                    },
                  ),
                ),
                controller: TextEditingController(text: _hora.format(context)),
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
              final dataProvider = Provider.of<DataProvider>(
                  context, listen: false);
              if (widget.reprogramacion == null) {
                dataProvider.addReprogramacion(Reprogramacion(
                  partido: widget.partido.competencia,
                  fecha: _fecha,
                  hora: _hora,
                  descripcion: _descripcion,
                ));
              } else {
                dataProvider.updateReprogramacion(
                  dataProvider.reprogramaciones.indexOf(widget.reprogramacion!),
                  Reprogramacion(
                    partido: widget.partido.competencia,
                    fecha: _fecha,
                    hora: _hora,
                    descripcion: _descripcion,
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