import 'package:flutter/material.dart';
import 'package:tennis_booking/src/ui/pages/home/home_page.dart';
import 'package:tennis_booking/src/ui/pages/reservation_list/reservation_list_page.dart';

import '../favorite/favorite_page.dart';

mixin BottomNavMixin<T extends StatefulWidget> on State<T> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (selectedIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReservationListPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FavoritePage()),
        );
        break;
    }
  }
}
