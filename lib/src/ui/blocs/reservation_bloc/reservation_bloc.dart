
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';

import '../../../domain/gateways/reservation_repository.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository repository;

  ReservationBloc(this.repository) : super(ReservationInitial()) {
    on<ReservationEvent>((event, emit) async {
      if(event is LoadReservationsEvent){
        debugPrint("loading reservations");
        List<Reservation> reservations = await repository.getUserReservations(event.userId);
        emit(ReservationLoaded(scheduledReservations: reservations));
      }
    });
  }
}
