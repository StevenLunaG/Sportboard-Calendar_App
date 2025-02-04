import 'dart:convert';

class Equipo {
  String nombre;

  Equipo({required this.nombre});

  Map<String, dynamic> toJson() => {'nombre': nombre};

  factory Equipo.fromJson(Map<String, dynamic> json) => Equipo(
    nombre: json['nombre'],
  );
}