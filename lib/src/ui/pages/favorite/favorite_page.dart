import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/ui/pages/mixin/bottom_nav_mixin.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_border_button.dart';

import '../../../blocs/fields/fields_bloc.dart';
import '../../../blocs/reservation/reservation_bloc.dart';
import '../../../domain/entities/field.dart';
import '../../../domain/entities/reservation.dart';
import '../mixin/appbar_mixin.dart';
import '../reservation_list/reservation_list_page.dart';
import '../widgets/navbar/custom_bottom_navbar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with AppBarMixin, BottomNavMixin {
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
                'Mis Favoritos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              listFavoriteReservations(fieldsBloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2, // Index para la página de favoritos
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
              Icons.calendar_today,
              color: Colors.white,
            ),
            SizedBox(width: 7),
            Text(
              'Ver todas las reservas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReservationListPage()),
        );
      },
    );
  }

  Widget listFavoriteReservations(FieldsBloc fieldsBloc,
      {bool fromHome = false}) {
    return BlocBuilder<FieldsBloc, FieldsState>(
      builder: (context, fieldsState) {
        if (fieldsState is FieldsAvailabilityLoaded) {
          return BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              if (state is ReservationLoaded) {
                return state.getFavorites().isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.getFavorites().length,
                          itemBuilder: (context, index) {
                            Reservation favReservation =
                                state.getFavorites()[index];

                            return buildFavoriteReservationCard(
                                favReservation, fieldsBloc, context);
                          },
                        ),
                      )
                    : noElements();
              } else if (state is ReservationLoading) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(),
                ));
              } else if (state is ReservationInitial) {
                return noElements();
              } else {
                return const Center(child: Text('Error al cargar favoritos.'));
              }
            },
          );
        } else {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }

  Center noElements() {
    return const Center(
      child: Text("No hay elementos en favoritos."),
    );
  }

  Widget buildFavoriteReservationCard(
      Reservation reservation, FieldsBloc fieldsBloc, BuildContext context) {
    Field field = (fieldsBloc.state as FieldsAvailabilityLoaded)
        .getFieldById(reservation.fieldId)!
        .field;

    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(field.name),
      subtitle: Wrap(
        children: [
          Text('Fecha: ${reservation.reservationDate}'),
          Text('Hora: ${reservation.startTime} a ${reservation.startTime}')
        ],
      ),
    );
  }
}
