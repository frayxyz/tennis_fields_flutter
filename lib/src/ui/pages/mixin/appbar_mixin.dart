import 'package:flutter/material.dart';

import '../widgets/texts/title_app_texts.dart';

mixin MixinAppbar{
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
}