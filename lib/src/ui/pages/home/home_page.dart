import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/authentication/authentication_bloc.dart';
import 'package:tennis_booking/src/ui/pages/mixin/list_reservation_mixin.dart';
import 'package:tennis_booking/src/ui/pages/mixin/appbar_mixin.dart';
import 'package:tennis_booking/src/utils/text_helper.dart';

import '../../../blocs/fields/fields_bloc.dart';
import '../../../blocs/instructor/instructor_bloc.dart';
import '../../../blocs/reservation/reservation_bloc.dart';
import '../mixin/bottom_nav_mixin.dart';
import '../widgets/cards/field_card.dart';
import '../widgets/navbar/custom_bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AppBarMixin, ListReservationMixin, BottomNavMixin {
  late final FieldsBloc fieldsBloc;
  late final String userName;

  @override
  void initState() {
    super.initState();
    fieldsBloc = context.read<FieldsBloc>();
    fieldsBloc.add(LoadFieldsWithAvailability());//LoadFieldsEvent());
    context.read<InstructorBloc>().add(FetchInstructors());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authBloc = context.read<AuthenticationBloc>();
    if (authBloc.state.status == AuthStatus.authenticated &&
        authBloc.state.userInfo != null) {
      userName = TextHelper.capitalizeText(context.read<AuthenticationBloc>().state.userInfo?.name ?? "");
      debugPrint("loading reservaion didChange");
      context.read<ReservationBloc>().add(LoadReservationsEvent(authBloc.state.userInfo!.id!));
    }
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
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: Text(
                  'Hola ${TextHelper.getFirstName(userName)}!',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 0.2),
              buildFieldsSection(),
              const Divider(color: Colors.grey, thickness: 0.2),
              buildScheduledReservationsSection()
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: onItemTapped,
      ),
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

  Container listFieldsAvailability() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 320,
      child:
          BlocBuilder<FieldsBloc, FieldsState>(builder: (context, fieldState) {
        if (fieldState is FieldsAvailabilityLoaded && fieldState.fields.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: fieldState.fields.length,
            itemBuilder: (context, index) {
              final fieldAvailability = fieldState.fields[index];
              return FieldCard(fieldAvailability: fieldAvailability);
            },
          );
        }else if(fieldState is  FieldsLoading) {
          return const Center(child: CircularProgressIndicator());
        }else {
          return const Center(child: Text("No fields available"));
        }
      }),
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
        listScheduledReservations(fieldsBloc, fromHome: true),
      ]),
    );
  }
}
