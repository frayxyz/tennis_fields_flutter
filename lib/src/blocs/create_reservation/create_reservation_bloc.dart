import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/field.dart';
import '../../utils/date_helper.dart';

part 'create_reservation_event.dart';
part 'create_reservation_state.dart';

class CreateReservationBloc extends Bloc<CreateReservationEvent, CreateReservationState> {

  CreateReservationBloc() : super(const CreateReservationState(
            reservationStatus: ReservationStatus.preInitial)) {
    on<CreateReservationEvent>((event, emit) async {
      if (event is CreateReservationPreInitialEvent) {
        emit(const CreateReservationState(
            reservationStatus: ReservationStatus.preInitial));
      } else if (event is CreateReservationInitialEvent) {
        if (state.reservationStatus == ReservationStatus.preInitial ||
            state.field?.id != event.fieldReservation.id) {
          emit(CreateReservationState(
              reservationStatus: ReservationStatus.initial,
              field: event.fieldReservation));
        }
        emit(state);
      } else if (event is CreateReservationSetDateEvent) {

        emit(state.copyWith(
          change: !state.change,
          reservationDate: event.reservationDate,
        ));
      } else if (event is CreateReservationSetInstructorEvent) {
        emit(state.copyWith(
            change: !state.change,
            instructorSelected: event.instructorId));
      } else if (event is CreateReservationSetStartTimeEvent) {
        emit(state.copyWith(
            change: !state.change,
            startTime: event.time));
      }else if (event is CreateReservationSetEndTimeEvent) {
        emit(state.copyWith(
            change: !state.change,
            endTime: event.time));
      } else if (event is CreateReservationSetCommentEvent) {
        emit(state.copyWith(
            change: !state.change,
            comment: event.comment));
      }else if (event is SetFavoriteEvent) {
        emit(state.copyWith(
            change: !state.change,
            isFavorite: event.favorite));
      } else if (event is ReservationCreatedEvent) {
        emit(const CreateReservationState(
            reservationStatus: ReservationStatus.preInitial));
      }
    });
  }

}
