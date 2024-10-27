part of 'create_reservation_bloc.dart';


class CreateReservationState extends Equatable {
  final Field? field;
  final ReservationStatus reservationStatus;
  final int? instructorSelected;
  final DateTime? reservationDate;
  final String? startTime;
  final String? endTime;
  final String? comment;
  final bool change;


  const CreateReservationState({
    this.field,
    this.reservationDate,
    this.comment,
    this.instructorSelected,
    required this.reservationStatus,
    this.startTime,
    this.endTime,
    this.change = false
  });

  @override
  List<Object?> get props => [field,reservationStatus,change];

  CreateReservationState copyWith({
    Field? field,
    DateTime? reservationDate,
    int? instructorSelected,
    ReservationStatus? reservationStatus,
    String? startTime,
    String? endTime,
    String? comment,
    bool? change
  }) {
    return CreateReservationState(
      field: field ?? this.field,
      reservationDate: reservationDate ?? this.reservationDate,
      instructorSelected: instructorSelected ?? this.instructorSelected,
      reservationStatus: reservationStatus ?? this.reservationStatus,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      change: change ?? this.change,
      comment: comment ?? this.comment
    );
  }

  bool isReadyToConfirm() {
    return (reservationDate != null && startTime != null && endTime != null);
  }

  double calculateTotalPrice(int pricePerHour){
    int durationInHours = 0;
    if(startTime != null && endTime != null){
      durationInHours = DateHelper.getDifferenceBetweenHours(startTime!,endTime!);
    }
    return durationInHours * pricePerHour.toDouble();
  }
}

enum ReservationStatus {
  preInitial,
  initial,
  setInstructor,
  setDate,
  setStartTime,
  setEndTime,
  setComment,
  timeSelected,
  complete
}
