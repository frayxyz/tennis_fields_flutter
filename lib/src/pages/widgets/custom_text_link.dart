import 'package:flutter/material.dart';

class CustomTextLink extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final String link;
  const CustomTextLink({
    super.key,
    required this.onTap,
    required this.text,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(text),
        InkWell(
          onTap: onTap,
          child: Text(link, style: const TextStyle(color: Colors.blueAccent)),
        ),
      ],
    );
  }
}