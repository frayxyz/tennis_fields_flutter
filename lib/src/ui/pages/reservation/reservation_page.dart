import 'package:flutter/material.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/back_icon_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';

import 'widgets/date_selectors/date_dropdown.dart';
import 'widgets/date_selectors/hour_dropdown.dart';
import 'widgets/field_details.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imageUrls = [
    'assets/images/tennis_image.jpg',
    'assets/images/tennis_image.jpg',
    'assets/images/tennis_image.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarouselImageAndButtons(context),

            const SizedBox(height: 18),

            // Details Section
            const FieldDetailsInfo(),

            const SizedBox(height: 16),

            // Date and Time Section
            Container(
              width: double.infinity,
              color: const Color(0xfff4f7fc),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Establecer fecha y hora",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  const SizedBox(height: 8),

                  DateDropdown(
                    title: "Fecha",
                    onDateSelected: (date) {
                      print("Selected date: $date");
                    },
                  ),
                  const SizedBox(height: 16),

                  // Selector de hora de inicio
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HourDropdown(
                          title: 'Hora de Inicio',
                          availableHours: ['08:00', '09:00', '10:00', '11:00', '12:00'],
                          onHourSelected: (hour) {
                            print('Hora de inicio seleccionada: $hour');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: HourDropdown(
                          title: 'Hora de Fin',
                          availableHours: ['13:00', '14:00', '15:00', '16:00', '17:00'],
                          onHourSelected: (hour) {
                            print('Hora de fin seleccionada: $hour');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text("Agregar un comentario", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 35),
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Agregar un comentario...",
                      ),
                      style: TextStyle(backgroundColor: Colors.white),
                    ),
                  ),

                  // Reserve Button
                  CustomButton("Reservar", onPressed: () {}),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Stack buildCarouselImageAndButtons(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        // Indicator Dots
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_imageUrls.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 11 : 13,
                height: _currentPage == index ? 11 : 13,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
        const Positioned(
          top: 16,
          left: 28,
          child: BackIconButton(),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.favorite_border),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
