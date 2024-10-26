import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_booking/src/data/repositories/fields_repository_impl.dart';
import 'package:tennis_booking/src/data/repositories/reservation_repository_impl.dart';
import 'package:tennis_booking/src/data/repositories/user_repository_impl.dart';

import 'package:tennis_booking/src/ui/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tennis_booking/src/ui/blocs/fields_bloc/fields_bloc.dart';
import 'package:tennis_booking/src/ui/pages/welcome/welcome_page.dart';

import 'src/ui/blocs/reservation_bloc/reservation_bloc.dart';
import 'src/ui/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(repository: UserRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => FieldsBloc(FieldsRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => ReservationBloc(ReservationRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xff82bc00),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: Colors.blue.shade800,
          ),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            debugPrint("state auth es $state");
            if (state.status == AuthStatus.authenticated) {
              return HomePage(); // Navigate to HomePage if authenticated
            } else {
              return const WelcomePage(); // Otherwise, go to WelcomePage
            }
          },
        ),
      ),
    );
  }
}
