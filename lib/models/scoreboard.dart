import 'team.dart';

class Scoreboard {
  final int? id;
  final int? homeScore;
  final int? guestScore;
  final bool? isFinished;
  final Team? winner;

  Scoreboard({
    this.id,
    this.homeScore,
    this.guestScore,
    this.isFinished,
    this.winner,
  });

  factory Scoreboard.fromJson(Map<String, dynamic> json) {
    return Scoreboard(
      id: json['id'],
      homeScore: json['homeScore'],
      guestScore: json['guestScore'],
      isFinished: json['isFinished'],
      winner: json['winner'] != null ? Team.fromJson(json['winner']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeScore': homeScore,
      'guestScore': guestScore,
      'isFinished': isFinished,
      'winner': winner?.toJson(),
    };
  }
}