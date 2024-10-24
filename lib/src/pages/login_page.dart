import 'package:flutter/material.dart';

import 'register_page.dart';
import 'widgets/appbar_image.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_link.dart';
import 'widgets/title_with_divider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AppbarImage(),
          buildLoginPageContent(context),
          buildLoginButton(),
          const SizedBox(height: 50.0),
          CustomTextLink(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            ),
            text: "¿Aún no tienes cuenta? ",
            link: "Regístrate",
          ),
        ],
      ),
    );
  }

  Container buildLoginPageContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      padding: const EdgeInsets.only(left: 30),
      width: MediaQuery.of(context).size.width,
      child: const Wrap(
        children: [
          TitleWithDivider(title: "Iniciar sesión"),
          TextField(
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
        ],
      ),
    );
  }

  CustomButton buildLoginButton() {
    return CustomButton("Iniciar sesión", onPressed: () {
      //login logic
    });
  }
}
