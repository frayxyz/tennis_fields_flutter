import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/ui/pages/mixin/bottom_nav_mixin.dart';
import 'package:tennis_booking/src/ui/pages/mixin/list_reservation_mixin.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_border_button.dart';

import '../../../blocs/fields/fields_bloc.dart';
import '../home/home_page.dart';
import '../mixin/appbar_mixin.dart';
import '../widgets/navbar/custom_bottom_navbar.dart';

class ReservationListPage extends StatefulWidget {
  const ReservationListPage({super.key});

  @override
  State<ReservationListPage> createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage>
    with AppBarMixin, ListReservationMixin, BottomNavMixin {
  late final FieldsBloc fieldsBloc;

  @override
  void initState() {
    super.initState();
    fieldsBloc = context.read<FieldsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              buildHeaderButton(context),
              const SizedBox(height: 30),
              const Text(
                'Mis Reservas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              listScheduledReservations(fieldsBloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: onItemTapped,
      ),
    );
  }

  CustomBorderButton buildHeaderButton(BuildContext context) {
    return CustomBorderButton(
        backgroundColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 7),
              Text(
                'Programar reserva',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())));
  }
}
