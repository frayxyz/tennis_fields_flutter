import 'package:flutter/material.dart';

import '../widgets/cards/field_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/texts/title_app_texts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: buildTitleAppBar(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff182d52), Theme.of(context).primaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        actions: buildAppbarActions(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 19, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hola User!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Canchas',
                style: TextStyle(fontSize: 18,),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    FieldCard(),
                    FieldCard(),
                    FieldCard(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Reservas Programadas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/place.jpg'), // Imagen de ejemplo
                    ),
                    title: Text('Reserva 1'),
                    subtitle: Text('Lugar: Salón de Belleza A'),
                    trailing: Text('10:00 AM'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/place.jpg'),
                    ),
                    title: Text('Reserva 2'),
                    subtitle: Text('Lugar: Barbería B'),
                    trailing: Text('11:00 AM'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/place.jpg'),
                    ),
                    title: Text('Reserva 2'),
                    subtitle: Text('Lugar: Barbería B'),
                    trailing: Text('11:00 AM'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/place.jpg'),
                    ),
                    title: Text('Reserva 2'),
                    subtitle: Text('Lugar: Barbería B'),
                    trailing: Text('11:00 AM'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Marcada la sección de Inicio
        onTap: (index) {
          // Controlar el cambio de pestañas aquí
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Reservas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  List<Widget> buildAppbarActions() {
    return [
        const CircleAvatar(
          radius: 12,
          backgroundImage:
              AssetImage('assets/images/tennis_image.jpg'), // Imagen de ejemplo
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

}
