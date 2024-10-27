import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/reservation/reservation_bloc.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/back_icon_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';

import '../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../../blocs/instructor/instructor_bloc.dart';
import 'widgets/date_selectors/date_dropdown.dart';
import 'widgets/date_selectors/hour_dropdown.dart';
import 'widgets/field_details.dart';
import 'widgets/modal/confirm_reservation_modal.dart';

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
            const FieldDetailsInfo(),
            Container(
              width: double.infinity,
              color: const Color(0xfff4f7fc),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Establecer fecha y hora",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  const SizedBox(height: 8),

                  DateDropdown(
                    title: "Fecha",
                    onDateSelected: (date) {
                      if (date != null) {
                        context.read<CreateReservationBloc>().add(
                            CreateReservationSetDateEvent(
                                reservationDate: date));
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<CreateReservationBloc, CreateReservationState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: HourDropdown(
                              defaultTime: state.startTime,
                              title: 'Hora de Inicio',
                              availableHours: DateHelper.generateHourlyIntervals(
                                  state.field!.openingTime,
                                  state.field!
                                      .closingTime), //['08:00', '09:00', '10:00', '11:00', '12:00'],
                              onHourSelected: (hour) {
                                print('Hora de inicio seleccionada: $hour');
                                if (hour != null) {
                                  context.read<CreateReservationBloc>().add(
                                      CreateReservationSetStartTimeEvent(
                                          time: hour));
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: HourDropdown(
                              defaultTime: state.endTime,
                              title: 'Hora de Fin',
                              availableHours: state.startTime != null
                                  ? DateHelper.generateHourlyIntervals(
                                      state.field!.openingTime,
                                      state.field!.closingTime)
                                  : [],
                              onHourSelected: (hour) {
                                print('Hora de fin seleccionada: $hour');
                                if (hour != null) {
                                  context.read<CreateReservationBloc>().add(
                                      CreateReservationSetEndTimeEvent(
                                          time: hour));
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text("Agregar un comentario",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 35),
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: BlocBuilder<CreateReservationBloc,
                        CreateReservationState>(
                      builder: (context, state) {
                        return TextFormField(
                          maxLines: 4,
                          initialValue: state.comment ??
                              "", // Usa el valor de 'state.comment' o una cadena vacía si es 'null'
                          onChanged: (value) {
                            context.read<CreateReservationBloc>().add(
                                  CreateReservationSetCommentEvent(
                                      comment: value),
                                );
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Agregar un comentario...",
                          ),
                          style: const TextStyle(backgroundColor: Colors.white),
                        );
                      },
                    ),
                  ),

                  // Reserve Button
                  BlocBuilder<CreateReservationBloc, CreateReservationState>(
                    builder: (context, state) {
                      return CustomButton(
                        "Reservar",
                        onPressed: state.isReadyToConfirm()
                            ? () {
                                showConfirmReservationModal(context, state);
                              }
                            : () {},
                        color: state.isReadyToConfirm()
                            ? null
                            : Theme.of(context).primaryColor.withOpacity(0.8),
                      );
                    },
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

  void showConfirmReservationModal(BuildContext context, CreateReservationState state) {
    String? instructorName;
    if(state.instructorSelected != null){
      final instructorState = context.read<InstructorBloc>().state;
      if(instructorState is InstructorsLoaded){
        instructorName = instructorState.getInstructorById(state.instructorSelected!)?.name;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmReservationModal(
          instructorName: instructorName??"Sin instructor",
          reservationDate: DateHelper.formatDateToString(state.reservationDate!),
          reservationTime: "${state.startTime} a ${state.endTime} hrs",
          price: state.calculateTotalPrice(state.field!.pricePerHour),
          onConfirm: () {
            // Lógica de confirmación, validaciones etc
            Reservation newReservation= Reservation(userId: 1,
              fieldId: state.field!.id!,
              reservationDate: DateHelper.formatDateToString(state.reservationDate!),
              startTime: state.startTime!,
              endTime: state.endTime!,
              status: 'created',
            );
            context.read<ReservationBloc>().add(AddReservationEvent(newReservation));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Reserva creada!"), backgroundColor: Theme.of(context).primaryColor),
            );
            Navigator.of(context).pop();//va a atras
            Navigator.of(context).pop();
            //se dirige a detalle reserva
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
