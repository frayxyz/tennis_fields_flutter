import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication_bloc.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../widgets/image/appbar_image.dart';
import '../widgets/buttons/custom_text_link.dart';
import '../widgets/forms/register_form.dart';
import '../widgets/texts/title_with_divider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        debugPrint("bloc listerner auth es: $state");
        if(state.status == AuthStatus.authenticated || state.status == AuthStatus.registerSuccess && state.userInfo?.name != null){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const HomePage()),
          );
        }
      },
      child: Scaffold(
        body: Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const AppbarImage(),
                    const SizedBox(height: 40.0),
                    const TitleWithDivider(title: "Registro"),
                    const RegisterForm(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: CustomTextLink(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  LoginPage()),
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
      ),
    );
  }
}
