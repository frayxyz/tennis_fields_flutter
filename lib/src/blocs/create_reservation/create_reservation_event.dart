part of 'create_reservation_bloc.dart';

abstract class CreateReservationEvent extends Equatable {
  const CreateReservationEvent();
}


class CreateReservationPreInitialEvent extends CreateReservationEvent{
  @override
  List<Object?> get props => [];
}

class CreateReservationInitialEvent extends CreateReservationEvent{
  final Field fieldReservation;

  const CreateReservationInitialEvent({required this.fieldReservation});
  @override
  List<Object?> get props => [fieldReservation];
}

class CreateReservationSetDateEvent extends CreateReservationEvent{
  final DateTime reservationDate;

  const CreateReservationSetDateEvent({required this.reservationDate});

  @override
  List<Object?> get props =>[reservationDate];
}

class CreateReservationSetInstructorEvent extends CreateReservationEvent{
  final int instructorId;
  const CreateReservationSetInstructorEvent({required this.instructorId});
  @override
  List<Object?> get props =>[instructorId];
}
class CreateReservationSetCommentEvent extends CreateReservationEvent{
  final String comment;
  const CreateReservationSetCommentEvent({required this.comment});
  @override
  List<Object?> get props =>[comment];
}

class CreateReservationSetStartTimeEvent extends CreateReservationEvent{
  final String time;

  const CreateReservationSetStartTimeEvent({required this.time});

  @override
  List<Object?> get props =>[time];
}

class CreateReservationSetEndTimeEvent extends CreateReservationEvent{
  final String time;

  const CreateReservationSetEndTimeEvent({required this.time});

  @override
  List<Object?> get props =>[time];
}

class ReservationCreatedEvent extends CreateReservationEvent{
  @override
  List<Object?> get props => [];
}