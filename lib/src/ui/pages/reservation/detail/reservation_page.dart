import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tennis_booking/src/domain/entities/field.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/back_icon_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_border_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/icon_text_row.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';

import '../widgets/field_details.dart';

class ReservationPage extends StatefulWidget {
  final Field field;
  final Reservation reservation;

  const ReservationPage(
      {super.key, required this.field, required this.reservation});

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
    int reservationHours = DateHelper.getDifferenceBetweenHours(
        widget.reservation.startTime, widget.reservation.endTime);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarouselImageAndButtons(context),
            const SizedBox(height: 18),
            FieldDetailsInfo(
              field: widget.field,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              color: const Color(0xfff4f7fc),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Resumen",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 16),
                  Wrap(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextRow(
                            icon: const Icon(Icons.sports_tennis),
                            text: "Cancha tipo ${widget.field.type}"),
                        const IconTextRow(
                            icon: Icon(Icons.calendar_today_outlined, size: 17),
                            text: " 10 de julio 2024") //todo fecha dinamica
                      ],
                    ),
                    SizedBox(
                        height: 10, width: MediaQuery.of(context).size.width),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const IconTextRow(
                              icon: Icon(Icons.person_outline_rounded),
                              text: "Instructor: Pepito Especific"),
                          Padding(
                            padding: const EdgeInsets.only(right: 35.0),
                            child: IconTextRow(
                                icon: const Icon(Icons.watch_later_outlined,
                                    size: 18),
                                text: " $reservationHours horas"),
                          )
                        ]),
                  ]),
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(bottom: 30),
                        child: const Text("Total a pagar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Positioned(
                          right: 0,
                          child: Column(
                            children: [
                              Text(
                                  "\$${reservationHours * widget.field.pricePerHour}",
                                  style: TextStyle(
                                      fontSize: 23,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold)),
                              Text("Por $reservationHours horas",
                                  style: const TextStyle(color: Colors.grey))
                            ],
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 20),
                    child: CustomBorderButton(
                        onPressed: () {},
                        borderColor: Theme.of(context).colorScheme.primary,
                        child: IconTextRow(
                          textColor: Theme.of(context).colorScheme.primary,
                          icon: Icon(Icons.calendar_today_outlined,
                              size: 17,
                              color: Theme.of(context).colorScheme.primary),
                          text: "  Reprogramar reserva",
                          center: true,
                        )),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    "Pagar",
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 50),
                    child: CustomBorderButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Center(child: Text("Cancelar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                  ),
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
