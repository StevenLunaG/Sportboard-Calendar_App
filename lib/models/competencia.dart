import 'dart:convert';

class Competencia {
  String nombre;
  DateTime fechaInicio;
  DateTime fechaFin;

  Competencia({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'fechaInicio': fechaInicio.toIso8601String(),
    'fechaFin': fechaFin.toIso8601String(),
  };

  factory Competencia.fromJson(Map<String, dynamic> json) => Competencia(
    nombre: json['nombre'],
    fechaInicio: DateTime.parse(json['fechaInicio']),
    fechaFin: DateTime.parse(json['fechaFin']),
  );
}