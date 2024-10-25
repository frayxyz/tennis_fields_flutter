
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../home/home_page.dart';
import '../register/register_page.dart';
import '../widgets/appbar_image.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_link.dart';
import '../widgets/title_with_divider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
  listener: (context, state) {
    debugPrint("bloc listerner auth es: $state");
    if(state.status == AuthStatus.authenticated){

      debugPrint("Navegar a pagina home");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
    }
  },
  child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AppbarImage(),
            buildLoginPageContent(context),
            buildLoginButton(context),
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
      ),
    ),
);
  }

  Widget buildLoginPageContent(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      padding: const EdgeInsets.only(left: 30),
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: [
          TitleWithDivider(title: "Iniciar sesión"),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
        ],
      ),
    );
  }

  CustomButton buildLoginButton(BuildContext context) {
    return CustomButton("Iniciar sesión", onPressed: () {
      context.read<AuthenticationBloc>().add(LoginEvent(email: _emailController.text, password: _passwordController.text));
    });
  }
}
