import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/blocs/authentication/authentication_bloc.dart';
import 'package:tennis_booking/src/ui/pages/welcome/welcome_page.dart';

import '../widgets/texts/title_app_texts.dart';

mixin AppBarMixin{
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
      actions: buildAppbarActions(context),
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

  List<Widget> buildAppbarActions(BuildContext context) {
    return [
      const CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
      IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {},
      ),
      PopupMenuButton<int>(
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.menu),
        onSelected: (int result) {
          if (result == 0) {
            Navigator.pushNamed(context, '/login');
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<int>(
            value: 0,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: (){
                context.read<AuthenticationBloc>().add(LogoutEvent());
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WelcomePage()));
              },
            ),
          ),
        ],
      ),
    ];
  }
}

