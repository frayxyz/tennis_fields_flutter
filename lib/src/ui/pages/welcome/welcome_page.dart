import 'package:flutter/material.dart';

import '../login/login_page.dart';
import '../register/register_page.dart';
import '../widgets/custom_button.dart';
import '../widgets/texts/title_app_texts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 65, right: 10),
                    child: TennisText(),
                  ),
                  Positioned(
                      top: 70,
                      child: CourtText())
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
