import 'package:flutter/material.dart';

class TitleWithDivider extends StatelessWidget {
  final String title;

  const TitleWithDivider({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
         Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Container(
            width: MediaQuery.of(context).size.width / 4,
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2, bottom: 40),
            child: const Divider(
              color: Colors.blueAccent,
              thickness: 2,
            ))
      ],
    );
  }
}