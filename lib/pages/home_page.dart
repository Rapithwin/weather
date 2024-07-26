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
  bool isLoading = false;

  Future refreshPage() async {
    setState(() {
      isLoading = true;
    });
    futureWeather = await getCurrentWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text(futureWeather.name),
                );
        },
      ),
    );
  }
}
