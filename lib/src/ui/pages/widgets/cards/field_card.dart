import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/domain/entities/field_availability/field_availability.dart';

import '../../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../../../domain/entities/field.dart';
import '../../../../utils/date_helper.dart';
import '../../reservation/make_reservation_page.dart';
import '../buttons/custom_button.dart';
import '../chance_of_rain.dart';

class FieldCard extends StatelessWidget {
  final FieldAvailability fieldAvailability;

  const FieldCard({
    super.key,
    required this.fieldAvailability,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCardImage(),
          buildCardInfo(context),
          reservationButton(context),
        ],
      ),
    );
  }

  Container buildCardImage() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage('assets/images/tennis_image.jpg'), // Imagen de ejemplo
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCardInfo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 14, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  fieldAvailability.field.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Positioned(
                  right: 12,
                  child: ChanceOfRainWidget())
              //const Stack()
            ],
          ),
          const SizedBox(height: 3),
          Text('Cancha tipo ${fieldAvailability.field.type}'),
          const SizedBox(height: 8),
          Wrap(children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 15,
            ),
            const SizedBox(width: 7),
            Text(DateHelper.formatDateLanguage(fieldAvailability.nextAvailableDate))
          ]),
          const SizedBox(height: 7),
          Row(
            children: [
              const Text("Disponible"),
              const SizedBox(width: 6),
              Icon(Icons.circle, size: 10, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 6),
              Text("${fieldAvailability.availableTimes[0]} a ${fieldAvailability.availableTimes[fieldAvailability.availableTimes.length -1]}")
            ],
          )
        ],
      ),
    );
  }

  Padding reservationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
      child: CustomButton(
        'Reservar',
        isCardButton: true,
        onPressed: () {
          //Agregar evento para empezar CrearReservation
          context.read<CreateReservationBloc>().add(CreateReservationInitialEvent(fieldReservation: fieldAvailability.field));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakeReservationPage(defaultAvailableDate: fieldAvailability.nextAvailableDate)),
          );
        },
      ),
    );
  }
}
