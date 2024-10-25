class Field {
  final int? id;
  final String name;
  final String location;
  final String openingTime;
  final String closingTime;
  final String type;

  Field({
    this.id,
    required this.name,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.type,
  });

  // Método para convertir un Map a un Field
  factory Field.fromMap(Map<String, dynamic> map) {
    return Field(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      openingTime: map['opening_time'],
      closingTime: map['closing_time'],
      type: map['type'],
    );
  }

  // Método para convertir un Field a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'type': type,
    };
  }
}
