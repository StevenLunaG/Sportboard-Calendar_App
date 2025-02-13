import 'competition.dart';
import 'enums/method.dart';
import 'leaderboard.dart';
import 'team.dart';
import 'match.dart';

class MatchOrganization {
  final int? id;
  final DateTime? date;
  final String? phase;
  final Method? method;
  final Leaderboard? positionTable;
  final Competition? competition;
  final List<Team>? activeTeams;
  final List<Match>? matches;

  MatchOrganization({
    this.id,
    this.date,
    this.phase,
    this.method,
    this.positionTable,
    this.competition,
    this.activeTeams,
    this.matches,
  });

  factory MatchOrganization.fromJson(Map<String, dynamic> json) {
    return MatchOrganization(
      id: json['id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      phase: json['phase'],
      method: json['method'] != null ? Method.values.firstWhere((e) => e.toString() == 'Method.' + json['method']) : null,
      positionTable: json['positionTable'] != null ? Leaderboard.fromJson(json['positionTable']) : null,
      competition: json['competition'] != null ? Competition.fromJson(json['competition']) : null,
      activeTeams: json['activeTeams'] != null
          ? (json['activeTeams'] as List).map((item) => Team.fromJson(item)).toList()
          : null,
      matches: json['matches'] != null
          ? (json['matches'] as List).map((item) => Match.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'phase': phase,
      'method': method?.toString().split('.').last,
      'positionTable': positionTable?.toJson(),
      'competition': competition?.toJson(),
      'activeTeams': activeTeams?.map((item) => item.toJson()).toList(),
      'matches': matches?.map((item) => item.toJson()).toList(),
    };
  }
}