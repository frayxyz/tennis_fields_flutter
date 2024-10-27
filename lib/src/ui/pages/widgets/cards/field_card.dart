import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../../../domain/entities/field.dart';
import '../../reservation/reservation_page.dart';
import '../buttons/custom_button.dart';
import '../change_of_rain.dart';

class FieldCard extends StatelessWidget {
  final Field field;

  const FieldCard({
    super.key,
    required this.field,
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
          image:
              AssetImage('assets/images/tennis_image.jpg'), // Imagen de ejemplo
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
                  field.name,
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
          Text('Cancha tipo ${field.type}'),
          const SizedBox(height: 8),
          const Wrap(children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 15,
            ),
            SizedBox(width: 7),
            Text("9 de Julio 2024")
          ]),
          const SizedBox(height: 7),
          const Text("Disponible")
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
          context.read<CreateReservationBloc>().add(CreateReservationInitialEvent(fieldReservation: field));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                const ReservationPage()),
          );
        },
      ),
    );
  }
}
