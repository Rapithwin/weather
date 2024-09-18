import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/pages/welcome_page.dart';

int? initScreen;
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
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
          labelLarge: TextStyle(
            fontFamily: "OpenSans",
            color: Constants.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        useMaterial3: true,
      ),
      home: initScreen == 0 || initScreen == null
          ? const WelcomePage()
          : const HomePage(),
    );
  }
}
