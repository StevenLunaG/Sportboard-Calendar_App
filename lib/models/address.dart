class Address {
  final int? id;
  final String? principalStreet;
  final String? secondaryStreet;
  final String? reference;

  Address({
    this.id,
    this.principalStreet,
    this.secondaryStreet,
    this.reference,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      principalStreet: json['principalStreet'],
      secondaryStreet: json['secondaryStreet'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'principalStreet': principalStreet,
      'secondaryStreet': secondaryStreet,
      'reference': reference,
    };
  }
}