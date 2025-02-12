import 'address.dart';

class PlayingField {
  final int? id;
  final String? name;
  final Address? address;

  PlayingField({
    this.id,
    this.name,
    this.address,
  });

  factory PlayingField.fromJson(Map<String, dynamic> json) {
    return PlayingField(
      id: json['id'],
      name: json['name'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address?.toJson(),
    };
  }
}