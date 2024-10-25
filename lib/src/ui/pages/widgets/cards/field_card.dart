import 'package:flutter/material.dart';

import '../custom_button.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image:
                  AssetImage('assets/images/tennis_image.jpg'), // Imagen de ejemplo
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Título de la Tarjeta',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: CustomButton('Reservar',
              isCardButton: true,
              onPressed: () {
                // Acción de reservar
              },
            ),
          ),
        ],
      ),
    );
  }
}