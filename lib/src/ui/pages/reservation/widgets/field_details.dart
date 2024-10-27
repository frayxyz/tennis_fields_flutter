import 'package:flutter/material.dart';

import '../../../../domain/entities/field.dart';
import '../../widgets/chance_of_rain.dart';

class FieldDetailsInfo extends StatelessWidget {
  final Field field;

  const FieldDetailsInfo({
    super.key, required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    field.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${field.pricePerHour}",
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
                  Text("Cancha tipo ${field.type}"),
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
                          " ${field.openingTime} a ${field.closingTime}"),
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
                  Text(field.location),
                ],
              ),
            ],
          )
    );
  }
}
