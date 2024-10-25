part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class LoadReservationsEvent extends ReservationEvent{
  final String userId;

  const LoadReservationsEvent(this.userId);
  @override
  List<Object?> get props =>[userId];
}