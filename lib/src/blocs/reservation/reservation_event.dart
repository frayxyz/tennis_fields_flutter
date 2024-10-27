part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class LoadReservationsEvent extends ReservationEvent{
  final int userId;

  const LoadReservationsEvent(this.userId);
  @override
  List<Object?> get props =>[userId];
}

class AddReservationEvent extends ReservationEvent{
  final Reservation reservation;

  const AddReservationEvent(this.reservation);
  @override
  List<Object?> get props =>[reservation];
}