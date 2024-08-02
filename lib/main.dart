import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/pages/welcome_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.darkBlue),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "OpenSans",
            color: Constants.darkBlue,
            fontWeight: FontWeight.w700,
            fontSize: 60,
          ),
          titleLarge: TextStyle(
            fontFamily: "OpenSans",
            color: Constants.darkBlue,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
          bodyLarge: TextStyle(
            fontFamily: "OpenSans",
            color: Constants.darkBlue,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          bodyMedium: TextStyle(
            fontFamily: "OpenSans",
            color: Constants.darkBlue,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
