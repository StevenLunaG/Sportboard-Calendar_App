class Round {
  final int? id;
  final DateTime? startDate;
  final DateTime? finishDate;

  Round({
    this.id,
    this.startDate,
    this.finishDate,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      id: json['id'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      finishDate: json['finishDate'] != null ? DateTime.parse(json['finishDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate?.toIso8601String(),
      'finishDate': finishDate?.toIso8601String(),
    };
  }
}