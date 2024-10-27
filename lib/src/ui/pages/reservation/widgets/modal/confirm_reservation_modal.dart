import 'package:flutter/material.dart';

import '../../../widgets/buttons/custom_button.dart';

class ConfirmReservationModal extends StatelessWidget {
  final String instructorName;
  final String reservationDate;
  final String reservationTime;
  final double price;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmReservationModal({
    super.key,
    required this.instructorName,
    required this.reservationDate,
    required this.reservationTime,
    required this.price,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Confirma tu Reserva",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text("Instructor: $instructorName"),
            const SizedBox(height: 10),
            Text("Fecha: $reservationDate"),
            const SizedBox(height: 10),
            Text("Hora: $reservationTime"),
            const SizedBox(height: 10),
            Text("Precio: \$${price.toStringAsFixed(2)}"),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton("Confirmar",
                  onPressed: onConfirm,
                  isCardButton: true,
                ),
                CustomButton("Cancelar",
                  onPressed: onCancel,
                  isCardButton: true,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
