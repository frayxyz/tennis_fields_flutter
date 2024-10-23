import 'package:flutter/material.dart';
import 'package:tennis_booking/src/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff82bc00),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff82bc00)),
        useMaterial3: true,

      ),
      home: const WelcomePage(),
    );
  }
}
