import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/authentication/authentication_bloc.dart';
import 'package:tennis_booking/src/ui/pages/widgets/icon_text_row.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';
import 'package:tennis_booking/src/utils/text_helper.dart';

import '../../../../domain/entities/field.dart';
import '../../../../domain/entities/reservation.dart';
import '../chance_of_rain.dart';

class ReservationCard extends StatelessWidget {
  final Field field;
  final Reservation reservation;
  const ReservationCard({
    super.key,
    required this.field,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    String userName = TextHelper.capitalizeText(context.read<AuthenticationBloc>().state.userInfo?.name ?? "");

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 73),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text( TextHelper.truncateText(field.name, maxLength: 18), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Cancha tipo ${field.type}'),
               SizedBox(height: 7),
                IconTextRow(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 15,
                    ),
                    text: DateHelper.formatDateLanguage(reservation.reservationDate)),
                SizedBox(height: 7),
                Row(
                  children: [
                    const Text('Reservado por: '),
                    const CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(width: 5),
                    Text(TextHelper.truncateText(userName, maxLength: 16)),
                  ],
                ),
                SizedBox(height: 6),
                IconTextRow(
                    icon: const Icon(Icons.watch_later_outlined),
                    text:
                        "${reservation.getReservationHours()} hora${reservation.getReservationHours() == 1 ? '' : 's'} | \$${reservation.getTotalPrice(field.pricePerHour.toInt())}")
              ],
            ),
          ),
          Positioned(
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage('assets/images/${field.image}'),
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              )),
          const Positioned(right: 0, child: ChanceOfRainWidget())
        ],
      ),
    );

  }
}
