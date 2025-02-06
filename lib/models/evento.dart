import 'package:flutter/material.dart';

enum Tipo { CAMBIO, GOL, TARJETA_AMARILLA, TARJETA_ROJA }

class Evento {
  final String partido;
  final String descripcion;
  final Tipo tipo;
  final TimeOfDay tiempo;

  Evento({
    required this.partido,
    required this.descripcion,
    required this.tipo,
    required this.tiempo,
  });

  Map<String, dynamic> toJson() => {
    'partido': partido,
    'descripcion': descripcion,
    'tipo': tipo.toString().split('.').last,
    'tiempo': {'hour': tiempo.hour, 'minute': tiempo.minute},
  };

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
    partido: json['partido'],
    descripcion: json['descripcion'],
    tipo: Tipo.values.firstWhere((e) => e.toString().split('.').last == json['tipo']),
    tiempo: TimeOfDay(
      hour: json['tiempo']['hour'],
      minute: json['tiempo']['minute'],
    ),
  );
}