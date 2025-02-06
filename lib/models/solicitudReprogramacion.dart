import 'package:flutter/material.dart';

class Reprogramacion {
  final String partido;
  final DateTime fecha;
  final TimeOfDay hora;
  final String descripcion;

  Reprogramacion({
    required this.partido,
    required this.fecha,
    required this.hora,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
    'partido': partido,
    'fecha': fecha.toIso8601String(),
    'hora': {'hour': hora.hour, 'minute': hora.minute},
    'descripcion': descripcion,
  };

  factory Reprogramacion.fromJson(Map<String, dynamic> json) => Reprogramacion(
    partido: json['partido'],
    fecha: DateTime.parse(json['fecha']),
    hora: TimeOfDay(
      hour: json['hora']['hour'],
      minute: json['hora']['minute'],
    ),
    descripcion: json['descripcion'],
  );

}