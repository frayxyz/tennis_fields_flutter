class Reservation {
  final int? id;
  final int userId;
  final int fieldId;
  final String reservationDate;
  final String startTime;
  final String endTime;
  final String status;
  final String? instructorId;
  final String? comment;

  Reservation({
    this.id,
    required this.userId,
    required this.fieldId,
    required this.reservationDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.instructorId,
    this.comment
  });

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      userId: map['user_id'],
      fieldId: map['field_id'],
      reservationDate: map['reservation_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      status: map['status'],
      instructorId: map['instructor_id'],
      comment: map['comment']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'field_id': fieldId,
      'reservation_date': reservationDate,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
      'instructor_id': instructorId,
      'comment': comment
    };
  }
}
