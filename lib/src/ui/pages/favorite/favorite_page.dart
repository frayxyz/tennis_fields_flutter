import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/ui/pages/mixin/bottom_nav_mixin.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_border_button.dart';

import '../../../blocs/fields/fields_bloc.dart';
import '../mixin/appbar_mixin.dart';
import '../reservation_list/reservation_list_page.dart';
import '../widgets/navbar/custom_bottom_navbar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with AppBarMixin, BottomNavMixin {
  late final FieldsBloc fieldsBloc;

  @override
  void initState() {
    super.initState();
    fieldsBloc = context.read<FieldsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context), // Método del mixin para crear el AppBar
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
              // Aquí puedes agregar un método para listar los elementos favoritos
              buildFavoritesList(),
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

  Widget buildFavoritesList() {
    // Aquí deberías implementar la lógica para obtener y mostrar la lista de favoritos
    // Por ejemplo, podrías usar un BlocBuilder para obtener la lista de favoritos del estado
    return BlocBuilder<FieldsBloc, FieldsState>(
      builder: (context, state) {
        if (state is FieldsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FieldsLoaded) {
          // Suponiendo que tienes una lista de favoritos en tu estado
          final favorites = state.fields; // Asegúrate de que esto coincida con tu estado real

          if (favorites.isEmpty) {
            return const Center(child: Text('No hay elementos en favoritos.'));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return ListTile(
                title: Text(favorite.name), // Asegúrate de que `favorite` tenga una propiedad `name`
                // Puedes agregar más información o widgets aquí según tu diseño
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para eliminar de favoritos
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Error al cargar favoritos.'));
        }
      },
    );
  }
}
