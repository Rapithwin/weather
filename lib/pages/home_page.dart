import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/api/geocoding_api.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/models/geocoding_model.dart';
import 'package:weather/models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CurrentWeather futureWeather;
  // Use latitude and longitue to call weather api
  late Position currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentWeather().then((value) => futureWeather = value);
    Geolocator.getCurrentPosition().then((value) => currentLocation = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(futureWeather.name),
            );
          }
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
