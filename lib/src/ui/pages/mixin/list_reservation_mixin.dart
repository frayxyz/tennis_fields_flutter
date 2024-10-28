import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/fields/fields_bloc.dart';

import '../../../blocs/reservation/reservation_bloc.dart';
import '../widgets/cards/reservation_card.dart';

mixin ListReservationMixin {

  Widget listScheduledReservations(FieldsBloc fieldsBloc,{bool fromHome=false}) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        debugPrint("state resrvation is $state");
        if (state is ReservationLoaded) {
          if (state.scheduledReservations.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.scheduledReservations.length,
                itemBuilder: (context, index) {
                  final reservation = state.scheduledReservations[index];
                  return fieldsBloc.getFieldById(reservation.fieldId) != null
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ReservationCard(
                        reservation: reservation,
                        field: fieldsBloc.getFieldById(reservation.fieldId)!),
                  )
                      : const SizedBox();
                },
              ),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("No tienes reservas programadas."),
              ),);
          }
        } else if (state is ReservationInitial || state is ReservationLoading) {
          return const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: CircularProgressIndicator(),
              ));
        } else {
          return const Center(
              child: Text("No se pudieron cargar las reservas."));
        }
      },
    );
  }

}
