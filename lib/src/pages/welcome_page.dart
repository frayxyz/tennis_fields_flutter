import 'package:flutter/material.dart';
import 'package:tennis_booking/src/pages/login_page.dart';
import 'package:tennis_booking/src/pages/register_page.dart';

import 'widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage(context),
          buildTitleWelcome(context),
          Positioned(bottom: 40, child: buildWelcomeButtons(context))
        ],
      ),
    );
  }

  Image buildBackgroundImage(BuildContext context) {
    return Image.asset(
          'assets/images/tennis_image.jpg',
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        );
  }

  Positioned buildTitleWelcome(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.14,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 65, right: 10),
                    child: Text(
                      'Tennis',
                      style: TextStyle(
                          fontSize: 65,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                      top: 70,
                      child: Container(
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
                        padding: const EdgeInsets.only(right: 30, left: 10),
                        child: const Text(
                          'court',
                          style: TextStyle(
                              fontSize: 65,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 0),
                          textAlign: TextAlign.center,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildWelcomeButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton("Iniciar sesión",
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  )),
          const SizedBox(height: 15), // Espacio entre botones
          CustomButton(
            "Registrarme",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            ),
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
