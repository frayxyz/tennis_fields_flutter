import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
      style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor),
      color: Colors.white,
    );
  }
}