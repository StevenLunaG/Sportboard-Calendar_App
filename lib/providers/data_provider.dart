import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/competencia.dart';
import '../models/partido.dart';
import '../models/equipo.dart';

class DataProvider extends ChangeNotifier {
  List<Competencia> _competencias = [];
  List<Partido> _partidos = [];
  List<Equipo> _equipos = [];

  List<Competencia> get competencias => _competencias;
  List<Partido> get partidos => _partidos;
  List<Equipo> get equipos => _equipos;

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

  // Agregar Equipo
  void addEquipo(Equipo equipo) {
    _equipos.add(equipo);
    _saveData();
    notifyListeners();
  }

  // Guardar datos en JSON (SharedPreferences)
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('competencias', jsonEncode(_competencias));
    prefs.setString('partidos', jsonEncode(_partidos));
    prefs.setString('equipos', jsonEncode(_equipos));
  }

  // Cargar datos al iniciar la app
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final competenciasData = prefs.getString('competencias');
    final partidosData = prefs.getString('partidos');
    final equiposData = prefs.getString('equipos');

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

    notifyListeners();
  }
  void updateEquipo(int index, Equipo equipo) {
    _equipos[index] = equipo;
    _saveData();
    notifyListeners();
  }

  // Editar Partido
  void updatePartido(int index, Partido partido) {
    _partidos[index] = partido;
    _saveData();
    notifyListeners();
  }
}
