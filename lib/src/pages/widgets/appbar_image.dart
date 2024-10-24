import 'package:flutter/material.dart';

class AppbarImage extends StatelessWidget {
  const AppbarImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(250),
              bottomRight: Radius.elliptical(125, 50)),
          child: Image.asset(
            'assets/images/tennis_image.jpg',
            width: MediaQuery.of(context).size.width,
            height: 250,
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
          ),
        ),
        Positioned(
          top: 30,
            left: 30,
            child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
              color: Colors.white,
        ))
      ],
    );
  }
}
