import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/rain_probability/rain_probability_bloc.dart';
import 'package:tennis_booking/src/domain/entities/reservation.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/back_icon_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';
import 'package:tennis_booking/src/utils/date_helper.dart';

import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../blocs/create_reservation/create_reservation_bloc.dart';
import '../../../blocs/reservation/reservation_bloc.dart';
import 'detail/confirm_reservation_page.dart';
import 'widgets/date_selectors/date_dropdown.dart';
import 'widgets/date_selectors/hour_dropdown.dart';
import 'widgets/field_details.dart';
import 'widgets/instructor_select/instructor_select.dart';

class ReservationPage extends StatefulWidget {
  final String defaultAvailableDate;
  const ReservationPage({super.key, required this.defaultAvailableDate});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imageUrls = [
    'assets/images/camp-1.jpg',
    'assets/images/camp-2.jpg',
    'assets/images/camp-3.jpg',
  ];
  late final RainProbabilityBloc rainProbabilityBloc;

  @override
  void initState() {
    super.initState();
    rainProbabilityBloc = context.read<RainProbabilityBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarouselImageAndButtons(context),
            const SizedBox(height: 18),
            BlocBuilder<CreateReservationBloc, CreateReservationState>(
              builder: (context, state) {
                return FieldDetailsInfo(
                  field: state.field!,
                );
              },
            ),
            const InstructorSelect(),
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
                    defaultAvailableDate: widget.defaultAvailableDate,
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<CreateReservationBloc, CreateReservationState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: buildInitialHour(state, context),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: buildFinalHour(state, context),
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
                            ? () async {

                                Reservation newReservation = Reservation(
                                    userId: context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .userInfo!
                                        .id!,
                                    fieldId: state.field!.id!,
                                    reservationDate:
                                        DateHelper.formatDateToString(
                                            state.reservationDate!),
                                    startTime: state.startTime!,
                                    endTime: state.endTime!,
                                    status: 'created',
                                    isFavorite: state.isFavorite);

                               int number = await context.read<ReservationBloc>().getFieldAvailabilityByDate(newReservation.fieldId, DateHelper.parseStringToDate(newReservation.reservationDate)!);
                                if(number >= 3){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Cambia la fecha de tu reserva, Campo alcanzó máximo de reservas por dia!")),
                                  );
                                }else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmReservationPage(
                                                field: state.field!,
                                                reservation: newReservation)),
                                  );
                                }


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

  HourDropdown buildFinalHour(
      CreateReservationState state, BuildContext context) {
    return HourDropdown(
      defaultTime: state.endTime,
      title: 'Hora de Fin',
      availableHours: state.startTime != null
          ? DateHelper.generateHourlyIntervals(
              state.field!.openingTime, state.field!.closingTime)
          : [],
      onHourSelected: (hour) {
        if (hour != null) {
          context
              .read<CreateReservationBloc>()
              .add(CreateReservationSetEndTimeEvent(time: hour));
        }
      },
    );
  }

  HourDropdown buildInitialHour(CreateReservationState state, BuildContext context) {
    return HourDropdown(
      defaultTime: state.startTime,
      title: 'Hora de Inicio',
      availableHours: DateHelper.generateHourlyIntervals(
          state.field!.openingTime, state.field!.closingTime
      ),
      onHourSelected: (hour) {
        if (hour != null) {
          context
              .read<CreateReservationBloc>()
              .add(CreateReservationSetStartTimeEvent(time: hour));
          CreateReservationState state =
              context.read<CreateReservationBloc>().state;
          if (state.dateIsSelected()) {
            rainProbabilityBloc.add(FetchRainProbability(
                DateHelper.formatDateToString(state.reservationDate!), hour));
          }
        }
      },
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
          child: BlocBuilder<CreateReservationBloc, CreateReservationState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Colors.white,
                onPressed: () {
                  context
                      .read<CreateReservationBloc>()
                      .add(SetFavoriteEvent(favorite: !state.isFavorite));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
