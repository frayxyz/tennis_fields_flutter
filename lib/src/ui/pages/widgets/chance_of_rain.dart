import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChanceOfRainWidget extends StatelessWidget {
  const ChanceOfRainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(CupertinoIcons.cloud_drizzle, color: Colors.blueAccent, size: 18),
        Text(" 30 %")
      ],
    );
  }
}