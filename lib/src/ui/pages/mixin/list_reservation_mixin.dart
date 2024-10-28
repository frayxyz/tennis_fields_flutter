import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/authentication/authentication_bloc.dart';
import 'package:tennis_booking/src/blocs/fields/fields_bloc.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';

import '../../../blocs/reservation/reservation_bloc.dart';
import '../widgets/cards/reservation_card.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';

mixin ListReservationMixin {
  Widget listScheduledReservations(FieldsBloc fieldsBloc,
      {bool fromHome = false}) {
    return BlocBuilder<FieldsBloc, FieldsState>(
      builder: (context, fieldsState) {
        if (fieldsState is FieldsAvailabilityLoaded) {
          return BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              debugPrint("state reservation is $state");
              if (state is ReservationLoaded) {
                return state.scheduledReservations.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.scheduledReservations.length,
                          itemBuilder: (context, index) {
                            final reservation =
                                state.scheduledReservations[index];

                            return fieldsState
                                        .getFieldById(reservation.fieldId) !=
                                    null
                                ? buildDismissibleReservationCard(
                                    reservation, fieldsBloc, context)
                                : const SizedBox();
                          },
                        ),
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Text("No tienes reservas programadas."),
                        ),
                      );
              } else if (state is ReservationInitial ||
                  state is ReservationLoading) {
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
        } else {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }

  Padding buildDismissibleReservationCard(Reservation reservation, FieldsBloc fieldsBloc, BuildContext context) {

    int userId = context.read<AuthenticationBloc>().state.userInfo!.id!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Dismissible(
        key: Key(reservation.id.toString()),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDeleteConfirmation(context);
        },
        onDismissed: (direction) {
          context
              .read<ReservationBloc>()
              .add(DeleteReservationEvent(reservation.id!, userId));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Reserva eliminada")),
          );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ReservationCard(
          reservation: reservation,
          field: (fieldsBloc.state as FieldsAvailabilityLoaded)
              .getFieldById(reservation.fieldId)!
              .field,
        ),
      ),
    );
  }

  Future<bool?> showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content:
              const Text("¿Estás seguro de que deseas eliminar esta reserva?"),
          actions: [
            CustomButton(
              "Confirmar",
              onPressed: () => Navigator.of(context).pop(true),
              isCardButton: true,
            ),
            CustomButton("Cancelar",
                onPressed: () => Navigator.of(context).pop(false),
                isCardButton: true,
                color: Colors.grey),
          ],
        );
      },
    );
  }
}
