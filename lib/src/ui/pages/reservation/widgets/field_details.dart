import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../widgets/change_of_rain.dart';
import 'instructor_select/instructor_select.dart';

class FieldDetailsInfo extends StatelessWidget {
  const FieldDetailsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: BlocBuilder<CreateReservationBloc, CreateReservationState>(
        builder: (context, state) {
          return Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.field!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${state.field!.pricePerHour}",
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cancha tipo ${state.field!.type}"),
                  const Text("Por hora"),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      const Text("Disponible "),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4, left: 5, right: 6),
                        child: Icon(Icons.circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 12),
                      ),
                      const Icon(Icons.access_time, size: 18),
                      Text(
                          " ${state.field!.openingTime} a ${state.field!.closingTime}"),
                    ],
                  ),
                  const ChanceOfRainWidget()
                ],
              ),
              const SizedBox(height: 28),
              Wrap(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 3),
                  Text(state.field!.location),
                ],
              ),
              const InstructorSelect(),

            ],
          );
        },
      ),
    );
  }
}
