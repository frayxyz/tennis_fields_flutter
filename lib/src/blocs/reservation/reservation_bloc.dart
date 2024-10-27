
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';

import '../../domain/entities/field.dart';
import '../../domain/gateways/reservation_repository.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository repository;

  ReservationBloc(this.repository) : super(ReservationInitial()) {
    on<ReservationEvent>((event, emit) async {
      if(event is LoadReservationsEvent){
        debugPrint("loading reservations");
        await loadReservations(event.userId, emit);
      }else if(event is AddReservationEvent){
        try {
          debugPrint("adding reservation");
          await repository.saveReservation(event.reservation);
          await loadReservations(event.reservation.userId, emit);
        } catch (error) {
          emit(ReservationError("Failed to save or load reservations: $error"));
        }
      }
    });
  }

  Future<void> loadReservations(int userId, Emitter<ReservationState> emit) async {
     List<Reservation> reservations = await repository.getUserReservations(userId);
    emit(ReservationLoaded(scheduledReservations: reservations));
  }

  Future<List<TimeOfDay>?>  getFieldAvailabilityByDate(Field field,DateTime date) async {

    List<Reservation> reservations =   await repository.getReservationsByFieldAndDate(field.id!, DateHelper.formatDateToString(date));
    List<TimeOfDay> times;//todo armas lista de horas según horario de campo
    //2 opc retornar todo y validar al final.. o retonar solo los horarios, q si
    //se podrian agendar pero poniendo validaciones extras front..

  }

  Future<List<TimeOfDay>?>  getInstructorAvailabilityByDate(int idInstructor,DateTime date) async {

    return null;
  }
}
