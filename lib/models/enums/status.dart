enum Status {
  PENDING,
  IN_PROGRESS,
  COMPLETED,
  CANCELLED;

  // Convertir de String a enum
  static Status fromString(String value) {
    return Status.values.firstWhere(
          (status) => status.name == value,
      orElse: () => Status.PENDING, // Valor por defecto si no se encuentra
    );
  }

  // Convertir enum a String
  String toJson() => name;
}