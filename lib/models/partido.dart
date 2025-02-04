// partido.dart
import 'package:flutter/material.dart';

class Partido {
  final String competencia;
  final DateTime fecha;
  final TimeOfDay hora;
  final String equipoLocal;
  final String equipoVisitante;

  Partido({
    required this.competencia,
    required this.fecha,
    required this.hora,
    required this.equipoLocal,
    required this.equipoVisitante,
  });

  Map<String, dynamic> toJson() => {
    'competencia': competencia,
    'fecha': fecha.toIso8601String(),
    'hora': {'hour': hora.hour, 'minute': hora.minute},
    'equipoLocal': equipoLocal,
    'equipoVisitante': equipoVisitante,
  };

  factory Partido.fromJson(Map<String, dynamic> json) => Partido(
    competencia: json['competencia'],
    fecha: DateTime.parse(json['fecha']),
    hora: TimeOfDay(
      hour: json['hora']['hour'],
      minute: json['hora']['minute'],
    ),
    equipoLocal: json['equipoLocal'],
    equipoVisitante: json['equipoVisitante'],
  );
}