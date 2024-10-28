import '../field.dart';

class FieldAvailability {
  final Field field;
  final String nextAvailableDate; // "dd/mm/yyyy"
  final List<String> availableTimes; //["10:00", "11:00", ...]

  FieldAvailability({
    required this.field,
    required this.nextAvailableDate,
    required this.availableTimes,
  });


  Map<String, dynamic> toJson() {
    return {
      'field': field.toMap(),
      'nextAvailableDate': nextAvailableDate,
      'availableTimes': availableTimes,
    };
  }

  factory FieldAvailability.fromJson(Map<String, dynamic> json) {
    return FieldAvailability(
      field: Field.fromMap(json['field']), // Supone que Field también tiene un método fromJson
      nextAvailableDate: json['nextAvailableDate'],
      availableTimes: List<String>.from(json['availableTimes']),
    );
  }
}
