import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/competencia.dart';
import '../models/partido.dart';
import '../models/equipo.dart';
import '../models/evento.dart';
import '../models/solicitudReprogramacion.dart';

class DataProvider extends ChangeNotifier {
  List<Competencia> _competencias = [];
  List<Partido> _partidos = [];
  List<Equipo> _equipos = [];
  List<Evento> _eventos = [];
  List<Reprogramacion> _reprogramaciones = [];

  List<Competencia> get competencias => _competencias;
  List<Partido> get partidos => _partidos;
  List<Equipo> get equipos => _equipos;
  List<Evento> get eventos => _eventos;
  List<Reprogramacion> get reprogramaciones => _reprogramaciones;

  DataProvider() {
    _loadData();
  }

  // Agregar Competencia
  void addCompetencia(Competencia competencia) {
    _competencias.add(competencia);
    _saveData();
    notifyListeners();
  }

  // Editar Competencia
  void updateCompetencia(int index, Competencia competencia) {
    _competencias[index] = competencia;
    _saveData();
    notifyListeners();
  }

  // Agregar Partido
  void addPartido(Partido partido) {
    _partidos.add(partido);
    _saveData();
    notifyListeners();
  }

  // Editar Partido
  void updatePartido(int index, Partido partido) {
    _partidos[index] = partido;
    _saveData();
    notifyListeners();
  }

  // Agregar Equipo
  void addEquipo(Equipo equipo) {
    _equipos.add(equipo);
    _saveData();
    notifyListeners();
  }

  // Editar Equipo
  void updateEquipo(int index, Equipo equipo) {
    _equipos[index] = equipo;
    _saveData();
    notifyListeners();
  }

  // Agregar Evento
  void addEvento(Evento evento) {
    _eventos.add(evento);
    _saveData();
    notifyListeners();
  }

  // Editar Evento
  void updateEvento(int index, Evento evento) {
    _eventos[index] = evento;
    _saveData();
    notifyListeners();
  }

  // Eliminar Evento
  void deleteEvento(int index) {
    _eventos.removeAt(index);
    _saveData();
    notifyListeners();
  }

  // Agregar Reprogramacion
  void addReprogramacion(Reprogramacion reprogramacion) {
    _reprogramaciones.add(reprogramacion);
    _saveData();
    notifyListeners();
  }

  // Editar Reprogramacion
  void updateReprogramacion(int index, Reprogramacion reprogramacion) {
    _reprogramaciones[index] = reprogramacion;
    _saveData();
    notifyListeners();
  }

  // Eliminar Reprogramacion
  void deleteReprogramacion(int index) {
    _reprogramaciones.removeAt(index);
    _saveData();
    notifyListeners();
  }

  // Eliminar Competencia
  void deleteCompetencia(int index) {
    String competenciaNombre = _competencias[index].nombre;
    _competencias.removeAt(index);
    _partidos.removeWhere((partido) => partido.competencia == competenciaNombre);
    _saveData();
    notifyListeners();
  }

  // Eliminar Partido
  void deletePartido(int index) {
    _partidos.removeAt(index);
    _saveData();
    notifyListeners();
  }

  // Eliminar Equipo
  void deleteEquipo(int index) {
    _equipos.removeAt(index);
    _saveData();
    notifyListeners();
  }

  // Guardar datos en JSON (SharedPreferences)
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('competencias', jsonEncode(_competencias));
    prefs.setString('partidos', jsonEncode(_partidos));
    prefs.setString('equipos', jsonEncode(_equipos));
    prefs.setString('eventos', jsonEncode(_eventos));
    prefs.setString('reprogramaciones', jsonEncode(_reprogramaciones));
  }

  // Cargar datos al iniciar la app
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final competenciasData = prefs.getString('competencias');
    final partidosData = prefs.getString('partidos');
    final equiposData = prefs.getString('equipos');
    final eventosData = prefs.getString('eventos');
    final reprogramacionesData = prefs.getString('reprogramaciones');

    if (competenciasData != null) {
      _competencias = (jsonDecode(competenciasData) as List)
          .map((item) => Competencia.fromJson(item))
          .toList();
    }
    if (partidosData != null) {
      _partidos = (jsonDecode(partidosData) as List)
          .map((item) => Partido.fromJson(item))
          .toList();
    }
    if (equiposData != null) {
      _equipos = (jsonDecode(equiposData) as List)
          .map((item) => Equipo.fromJson(item))
          .toList();
    }
    if (eventosData != null) {
      _eventos = (jsonDecode(eventosData) as List)
          .map((item) => Evento.fromJson(item))
          .toList();
    }
    if (reprogramacionesData != null) {
      _reprogramaciones = (jsonDecode(reprogramacionesData) as List)
          .map((item) => Reprogramacion.fromJson(item))
          .toList();
    }

    notifyListeners();
  }
}