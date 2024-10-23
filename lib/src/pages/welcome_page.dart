import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder borderButton =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

    return Scaffold(
      backgroundColor: const Color(0xff011537),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          buildTitleWelcome(context),

          Positioned(
              bottom: 40,
              child: buildWelcomeButtons(borderButton, context)
          )
        ],
      ),
    );
  }

  Positioned buildTitleWelcome(BuildContext context) {
    return Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child:  Column(
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
                        child:  Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Theme.of(context).primaryColor.withOpacity(0.01),
                                // Completamente transparente al inicio
                                Theme.of(context).primaryColor, // Color primario al final
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
                              height: 0
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      )
                    ],
                  ),
                ],
              ),
            ));
  }

  Widget buildWelcomeButtons(
      RoundedRectangleBorder borderButton, BuildContext context) {
    TextStyle textStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Aquí va la lógica cuando se presiona el botón verde
              print('Botón verde presionado');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: borderButton,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
            ),
            child: Text('Iniciar sesión', style: textStyle),
          ),
          const SizedBox(height: 15), // Espacio entre botones
          ElevatedButton(
            onPressed: () {
              // Aquí va la lógica cuando se presiona el botón gris
              print('Botón gris presionado');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.grey.withOpacity(0.5),
              foregroundColor: Colors.white,
              shape: borderButton,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
            ),
            child: Text(
              'Registrarme',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
