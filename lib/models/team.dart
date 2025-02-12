class Team {
  final int? id;
  final String name;
  // Agrega otros campos según tu modelo

  Team({
    this.id,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}