import 'competition.dart';
import 'match.dart';

class Leaderboard {
  final int? id;
  final Competition? competition;
  final DateTime? lastUpdate;
  final List<Match>? resultList;

  Leaderboard({
    this.id,
    this.competition,
    this.lastUpdate,
    this.resultList,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      id: json['id'],
      competition: json['competition'] != null ? Competition.fromJson(json['competition']) : null,
      lastUpdate: json['lastUpdate'] != null ? DateTime.parse(json['lastUpdate']) : null,
      resultList: json['resultList'] != null
          ? (json['resultList'] as List).map((item) => Match.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'competition': competition?.toJson(),
      'lastUpdate': lastUpdate?.toIso8601String(),
      'resultList': resultList?.map((item) => item.toJson()).toList(),
    };
  }
}