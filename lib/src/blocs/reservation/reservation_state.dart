part of 'reservation_bloc.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();
}

class ReservationInitial extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationLoading extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationLoaded extends ReservationState {
  final List<Reservation> scheduledReservations;

  const ReservationLoaded({required this.scheduledReservations});

  @override
  List<Object?> get props => [scheduledReservations];

}

class ReservationError extends ReservationState {
  final String message;

  const ReservationError(this.message);
  @override
  List<Object> get props => [message];
}