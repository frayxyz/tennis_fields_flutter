part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class LoadFieldsEvent extends ReservationEvent{
  @override
  List<Object?> get props =>[];
}