// lib/models/match.dart
import 'package:intl/intl.dart';
import 'team.dart';
import 'scoreboard.dart';
import 'playing_field.dart';
import 'enums/status.dart';

class Match {
  final int? id;
  final DateTime? date;
  final String? startTime;  // Guardamos el time como String en formato HH:mm
  final Team? homeTeam;
  final Team? guestTeam;
  final int? duration;
  final String? finishTime;  // Guardamos el time como String en formato HH:mm
  final Scoreboard? scoreboard;
  final PlayingField? count;
  final Status status;

  Match({
    this.id,
    this.date,
    this.startTime,
    this.homeTeam,
    this.guestTeam,
    this.duration,
    this.finishTime,
    this.scoreboard,
    this.count,
    this.status = Status.PENDING,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      // Convertir la fecha de String a DateTime
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      // Mantener el tiempo como String
      startTime: json['startTime'],
      homeTeam: json['homeTeam'] != null ? Team.fromJson(json['homeTeam']) : null,
      guestTeam: json['guestTeam'] != null ? Team.fromJson(json['guestTeam']) : null,
      duration: json['duration'],
      finishTime: json['finishTime'],
      scoreboard: json['scoreboard'] != null ? Scoreboard.fromJson(json['scoreboard']) : null,
      count: json['count'] != null ? PlayingField.fromJson(json['count']) : null,
      status: json['status'] != null ? Status.fromString(json['status']) : Status.PENDING,
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    return {
      'id': id,
      // Formatear la fecha como String en formato ISO
      'date': date != null ? dateFormatter.format(date!) : null,
      'startTime': startTime,
      'homeTeam': homeTeam?.toJson(),
      'guestTeam': guestTeam?.toJson(),
      'duration': duration,
      'finishTime': finishTime,
      'scoreboard': scoreboard?.toJson(),
      'count': count?.toJson(),
      'status': status.toJson(),
    };
  }

  // Métodos de ayuda para formatear la fecha y hora para mostrar en la UI
  String get formattedDate {
    if (date == null) return 'No date';
    return DateFormat('dd/MM/yyyy').format(date!);
  }

  String get formattedStartTime {
    return startTime ?? 'No start time';
  }

  String get formattedFinishTime {
    return finishTime ?? 'No finish time';
  }

  // Método para crear una copia del Match con campos actualizados
  Match copyWith({
    int? id,
    DateTime? date,
    String? startTime,
    Team? homeTeam,
    Team? guestTeam,
    int? duration,
    String? finishTime,
    Scoreboard? scoreboard,
    PlayingField? count,
    Status? status,
  }) {
    return Match(
      id: id ?? this.id,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      homeTeam: homeTeam ?? this.homeTeam,
      guestTeam: guestTeam ?? this.guestTeam,
      duration: duration ?? this.duration,
      finishTime: finishTime ?? this.finishTime,
      scoreboard: scoreboard ?? this.scoreboard,
      count: count ?? this.count,
      status: status ?? this.status,
    );
  }
}