// lib/models/match.dart
  import 'package:intl/intl.dart';
  import 'package:flutter/material.dart';
  import 'team.dart';
  import 'scoreboard.dart';
  import 'playing_field.dart';
  import 'enums/status.dart';

  class Match {
    final int? id;
    final DateTime? date;
    final TimeOfDay? startTime;
    final Team? homeTeam;
    final Team? guestTeam;
    final int? duration;
    final TimeOfDay? finishTime;
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
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
        startTime: json['startTime'] != null
            ? TimeOfDay(
                hour: int.parse(json['startTime'].split(':')[0]),
                minute: int.parse(json['startTime'].split(':')[1]),
              )
            : null,
        homeTeam: json['homeTeam'] != null ? Team.fromJson(json['homeTeam']) : null,
        guestTeam: json['guestTeam'] != null ? Team.fromJson(json['guestTeam']) : null,
        duration: json['duration'],
        finishTime: json['finishTime'] != null
            ? TimeOfDay(
                hour: int.parse(json['finishTime'].split(':')[0]),
                minute: int.parse(json['finishTime'].split(':')[1]),
              )
            : null,
        scoreboard: json['scoreboard'] != null ? Scoreboard.fromJson(json['scoreboard']) : null,
        count: json['count'] != null ? PlayingField.fromJson(json['count']) : null,
        status: json['status'] != null ? Status.fromString(json['status']) : Status.PENDING,
      );
    }

    Map<String, dynamic> toJson() {
      final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

      return {
        'id': id,
        'date': date != null ? dateFormatter.format(date!) : null,
        'startTime': startTime != null ? '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}' : null,
        'homeTeam': homeTeam?.toJson(),
        'guestTeam': guestTeam?.toJson(),
        'duration': duration,
        'finishTime': finishTime != null ? '${finishTime!.hour.toString().padLeft(2, '0')}:${finishTime!.minute.toString().padLeft(2, '0')}' : null,
        'scoreboard': scoreboard?.toJson(),
        'count': count?.toJson(),
        'status': status.toJson(),
      };
    }

    String get formattedDate {
      if (date == null) return 'No date';
      return DateFormat('dd/MM/yyyy').format(date!);
    }

    String get formattedStartTime {
      return startTime != null ? '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}' : 'No start time';
    }

    String get formattedFinishTime {
      return finishTime != null ? '${finishTime!.hour.toString().padLeft(2, '0')}:${finishTime!.minute.toString().padLeft(2, '0')}' : 'No finish time';
    }

    Match copyWith({
      int? id,
      DateTime? date,
      TimeOfDay? startTime,
      Team? homeTeam,
      Team? guestTeam,
      int? duration,
      TimeOfDay? finishTime,
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