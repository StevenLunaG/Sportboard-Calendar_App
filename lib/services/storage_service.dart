import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/competencia.dart';
import '../models/equipo.dart';
import '../models/partido.dart';

class StorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Archivos específicos
  Future<File> get _competenciaFile async => File('${await _localPath}/competencia.json');
  Future<File> get _partidosFile async => File('${await _localPath}/partidos.json');
  Future<File> get _equiposFile async => File('${await _localPath}/equipos.json');

  // Guardar y cargar Competencia
  Future<void> saveCompetencia(Competencia competencia) async {
    final file = await _competenciaFile;
    await file.writeAsString(jsonEncode(competencia.toJson()));
  }

  Future<Competencia?> loadCompetencia() async {
    final file = await _competenciaFile;
    if (await file.exists()) {
      return Competencia.fromJson(jsonDecode(await file.readAsString()));
    }
    return null;
  }

  // Guardar y cargar Partidos
  Future<void> savePartidos(List<Partido> partidos) async {
    final file = await _partidosFile;
    await file.writeAsString(jsonEncode(partidos.map((p) => p.toJson()).toList()));
  }

  Future<List<Partido>> loadPartidos() async {
    final file = await _partidosFile;
    if (await file.exists()) {
      List<dynamic> jsonData = jsonDecode(await file.readAsString());
      return jsonData.map((p) => Partido.fromJson(p)).toList();
    }
    return [];
  }

  // Guardar y cargar Equipos
  Future<void> saveEquipos(List<Equipo> equipos) async {
    final file = await _equiposFile;
    await file.writeAsString(jsonEncode(equipos.map((e) => e.toJson()).toList()));
  }

  Future<List<Equipo>> loadEquipos() async {
    final file = await _equiposFile;
    if (await file.exists()) {
      List<dynamic> jsonData = jsonDecode(await file.readAsString());
      return jsonData.map((e) => Equipo.fromJson(e)).toList();
    }
    return [];
  }
}
