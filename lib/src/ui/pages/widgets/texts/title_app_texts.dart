import 'package:flutter/material.dart';

class TennisText extends StatelessWidget {
  final bool isTitleAppbar;

  const TennisText({
    super.key,
    this.isTitleAppbar = false
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tennis',
      style: TextStyle(
          fontSize: isTitleAppbar? 24:65,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class CourtText extends StatelessWidget {
  final bool isTitleAppbar;

  const CourtText({
    super.key,
    this.isTitleAppbar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.01),
            // Completamente transparente al inicio
            Theme.of(context)
                .primaryColor, // Color primario al final
          ],
        ),
      ),
      margin: const EdgeInsets.only(left: 5),
      padding: EdgeInsets.only(right: isTitleAppbar? 13: 30, left: 10),
      child: Text(
        'court',
        style: TextStyle(
            fontSize: isTitleAppbar? 24: 65,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            height: 0),
        textAlign: TextAlign.center,
      ),
    );
  }
}