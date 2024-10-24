import 'package:flutter/material.dart';

import 'login_page.dart';
import 'widgets/appbar_image.dart';
import 'widgets/custom_text_link.dart';
import 'widgets/forms/register_form.dart';
import 'widgets/title_with_divider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const AppbarImage(),
                const SizedBox(height: 40.0),
                const TitleWithDivider(title:"Registro"),
                const RegisterForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: CustomTextLink(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    ),
                    text: "Ya tengo cuenta ",
                    link: "Iniciar sesión",
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
