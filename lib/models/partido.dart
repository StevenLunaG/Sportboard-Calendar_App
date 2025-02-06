// partido.dart
import 'package:flutter/material.dart';

enum Estado { PENDIENTE, EN_JUEGO, TERMINADO }

class Partido {
  final String competencia;
  final DateTime fecha;
  final TimeOfDay hora;
  final String equipoLocal;
  final String equipoVisitante;
  Estado estado;
  int marcadorLocal;
  int marcadorVisitante;

  Partido({
    required this.competencia,
    required this.fecha,
    required this.hora,
    required this.equipoLocal,
    required this.equipoVisitante,
    required this.estado,
    required this.marcadorLocal,
    required this.marcadorVisitante,
  });

  void updateMarcadorLocal(int marcador) {
    marcadorLocal = marcador;
  }

  void updateMarcadorVisitante(int marcador) {
    marcadorVisitante = marcador;
  }

  Map<String, dynamic> toJson() => {
    'competencia': competencia,
    'fecha': fecha.toIso8601String(),
    'hora': {'hour': hora.hour, 'minute': hora.minute},
    'equipoLocal': equipoLocal,
    'equipoVisitante': equipoVisitante,
    'estado': estado.toString().split('.').last,
    'marcadorLocal': marcadorLocal,
    'marcadorVisitante': marcadorVisitante,
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
    estado: Estado.values.firstWhere((e) => e.toString().split('.').last == json['estado']),
    marcadorLocal: json['marcadorLocal'],
    marcadorVisitante: json['marcadorVisitante'],
  );
}