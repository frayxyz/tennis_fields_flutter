class Field {
  final int? id;
  final String name;
  final String location;
  final String openingTime;
  final String closingTime;
  final int pricePerHour;
  final String type;
  final String image;

  Field({
    this.id,
    required this.name,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.pricePerHour,
    required this.type,
    required this.image
  });

  factory Field.fromMap(Map<String, dynamic> map) {
    return Field(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      openingTime: map['opening_time'],
      closingTime: map['closing_time'],
      pricePerHour: map['price_per_hour'],
      type: map['type'],
      image: map['image']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'price_per_hour': pricePerHour,
      'type': type,
      'image': image
    };
  }
}
