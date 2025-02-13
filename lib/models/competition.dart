import 'match_organization.dart';

class Competition {
  final int? id;
  final String? name;
  final String? type;
  final DateTime? startDate;
  final List<MatchOrganization>? matchOrganizations;

  Competition({
    this.id,
    this.name,
    this.type,
    this.startDate,
    this.matchOrganizations,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      matchOrganizations: json['matchOrganizations'] != null
          ? (json['matchOrganizations'] as List).map((item) => MatchOrganization.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'startDate': startDate?.toIso8601String(),
      'matchOrganizations': matchOrganizations?.map((item) => item.toJson()).toList(),
    };
  }

  Competition copyWith({
    int? id,
    String? name,
    String? type,
    DateTime? startDate,
    List<MatchOrganization>? matchOrganizations,
  }) {
    return Competition(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      matchOrganizations: matchOrganizations ?? this.matchOrganizations,
    );
  }
}