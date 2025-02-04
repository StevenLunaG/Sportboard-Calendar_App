import 'package:flutter/material.dart';
import '../models/partido.dart';
import 'data_provider.dart';

class CalendarProvider with ChangeNotifier {
  final DataProvider _dataProvider;
  Map<DateTime, List<Partido>> _partidosPorFecha = {};

  CalendarProvider(this._dataProvider) {
    _initializePartidos();
    // Escuchar cambios en el DataProvider
    _dataProvider.addListener(_initializePartidos);
  }

  Map<DateTime, List<Partido>> get partidosPorFecha => _partidosPorFecha;

  void _initializePartidos() {
    _partidosPorFecha = {};
    for (var partido in _dataProvider.partidos) {
      final fecha = DateTime(
        partido.fecha.year,
        partido.fecha.month,
        partido.fecha.day,
      );

      if (!_partidosPorFecha.containsKey(fecha)) {
        _partidosPorFecha[fecha] = [];
      }
      _partidosPorFecha[fecha]!.add(partido);
    }
    notifyListeners();
  }

  List<Partido> getPartidosByDate(DateTime date) {
    final fechaNormalizada = DateTime(date.year, date.month, date.day);
    return _partidosPorFecha[fechaNormalizada] ?? [];
  }

  bool hasPartidos(DateTime date) {
    final fechaNormalizada = DateTime(date.year, date.month, date.day);
    return _partidosPorFecha.containsKey(fechaNormalizada);
  }

  @override
  void dispose() {
    _dataProvider.removeListener(_initializePartidos);
    super.dispose();
  }
}