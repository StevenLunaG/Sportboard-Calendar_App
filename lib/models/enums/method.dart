enum Method {
  RAFFLE,
  MANUAL,
  ACCORDING_RESULTS;

  // Convert from String to enum
  static Method fromString(String value) {
    return Method.values.firstWhere(
      (method) => method.name == value,
      orElse: () => Method.RAFFLE, // Default value if not found
    );
  }

  // Convert enum to String
  String toJson() => name;
}