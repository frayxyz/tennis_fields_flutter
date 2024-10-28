
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';

import '../../domain/gateways/reservation_repository.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository repository;

  ReservationBloc(this.repository) : super(ReservationInitial()) {
    on<ReservationEvent>((event, emit) async {
      if(event is LoadReservationsEvent){
        emit(ReservationLoading());
        debugPrint("loading reservations");
        await loadReservations(event.userId, emit);
      }else if(event is AddReservationEvent){
        try {
          debugPrint("adding reservation");
          emit(ReservationLoading());
          await repository.saveReservation(event.reservation);
          await loadReservations(event.reservation.userId, emit);
        } catch (error) {
          emit(ReservationError("Failed to save or load reservations: $error"));
        }
      }else if(event is DeleteReservationEvent){
        try {
          debugPrint("deleting reservation");
          emit(ReservationLoading());
          await repository.deleteReservation(event.idReservation);

          await loadReservations(event.userId, emit);
        } catch (error) {
          emit(ReservationError("Failed to delete or load reservations: $error"));
        }
      }
    });
  }

  Future<void> loadReservations(int userId, Emitter<ReservationState> emit) async {
     List<Reservation> reservations = await repository.getUserReservations(userId);
     sortByDateAsc(reservations);

    emit(ReservationLoaded(scheduledReservations: reservations));
  }

  void sortByDateAsc(List<Reservation> reservations) {
    return reservations.sort((a, b) {
     final datePartsA = a.reservationDate.split('/');
     final timePartsA = a.startTime.split(':');

     final datePartsB = b.reservationDate.split('/');
     final timePartsB = b.startTime.split(':');

     final dateTimeA = DateTime(
       int.parse(datePartsA[2]),
       int.parse(datePartsA[1]),
       int.parse(datePartsA[0]),
       int.parse(timePartsA[0]),
       int.parse(timePartsA[1]),
     );

     final dateTimeB = DateTime(
       int.parse(datePartsB[2]),
       int.parse(datePartsB[1]),
       int.parse(datePartsB[0]),
       int.parse(timePartsB[0]),
       int.parse(timePartsB[1]),
     );

     return dateTimeA.compareTo(dateTimeB);
   });
  }

  Future<int>  getFieldAvailabilityByDate(int fieldId,DateTime date) async {
    return await repository.getReservationCountByFieldAndDate(fieldId ,date);
  }

}
