import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/authentication/authentication_bloc.dart';

import '../../../blocs/fields/fields_bloc.dart';
import '../../../blocs/instructor/instructor_bloc.dart';
import '../../../blocs/reservation/reservation_bloc.dart';
import '../widgets/cards/field_card.dart';
import '../widgets/cards/reservation_card.dart';
import '../widgets/navbar/custom_bottom_navbar.dart';
import '../widgets/texts/title_app_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FieldsBloc fieldsBloc;
  @override
  void initState() {
    super.initState();
    fieldsBloc = context.read<FieldsBloc>();
    fieldsBloc.add(LoadFieldsEvent());
    context.read<InstructorBloc>().add(FetchInstructors());
  }

  @override
  void didChangeDependencies() {
    final authBloc = context.read<AuthenticationBloc>();
    if (authBloc.state.status == AuthStatus.authenticated &&
        authBloc.state.userInfo != null) {
      debugPrint("loading reservaion didChange");
      context.read<ReservationBloc>().add(LoadReservationsEvent(authBloc.state.userInfo!.id!));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 19),
                child: Text(
                  'Hola User!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 10),
              buildFieldsSection(),
              const Divider(height: 20),
              buildScheduledReservationsSection()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  AppBar buildHomeAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: buildTitleAppBar(),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xff182d52), Theme.of(context).primaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      actions: buildAppbarActions(),
    );
  }

  Widget buildFieldsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, top: 12),
      child: Wrap(children: [
        const Text('Canchas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        listFieldsAvailability(),
      ]),
    );
  }

  Widget buildScheduledReservationsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 19),
      child: Wrap(children: [
        const Text(
          'Reservas Programadas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        listScheduledReservations(),
      ]),
    );
  }

  Wrap buildTitleAppBar() {
    return const Wrap(
      children: [
        TennisText(isTitleAppbar: true),
        CourtText(
          isTitleAppbar: true,
        )
      ],
    );
  }

  List<Widget> buildAppbarActions() {
    return [
      const CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/images/tennis_image.jpg'),
      ),
      IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
    ];
  }

  Container listFieldsAvailability() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 320,
      child:
          BlocBuilder<FieldsBloc, FieldsState>(builder: (context, fieldState) {
        if (fieldState is FieldsLoaded && fieldState.fields.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: fieldState.fields.length,
            itemBuilder: (context, index) {
              final field = fieldState.fields[index];
              return FieldCard(field: field);
            },
          );
        } else {
          return const Center(child: Text("No fields available"));
        }
      }),
    );
  }

  Widget listScheduledReservations() {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        debugPrint("state resrvation is $state");
        if (state is ReservationLoaded) {
          if (state.scheduledReservations.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.scheduledReservations.length,
                itemBuilder: (context, index) {
                  final reservation = state.scheduledReservations[index];
                  return fieldsBloc.getFieldById(reservation.fieldId) != null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ReservationCard(
                        reservation: reservation,
                        field: fieldsBloc.getFieldById(reservation.fieldId)!),
                      )
                      : const SizedBox();
                },
              ),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("No tienes reservas programadas."),
              ),);
          }
        } else if (state is ReservationInitial || state is ReservationLoading) {
          return const Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: CircularProgressIndicator(),
              ));
        } else {
          return const Center(
              child: Text("No se pudieron cargar las reservas."));
        }
      },
    );
  }
}
