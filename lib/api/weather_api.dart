import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/geocoding_api.dart';
import 'package:weather/models/forecast_model.dart';
import 'package:weather/models/geocoding_model.dart';
import 'package:weather/models/weather_model.dart';

class WeatherAPI {
  final String apiKey = dotenv.env["API_KEY"]!;
  late double lat;
  late double lon;
  late List<Geocoding>? futureGeo;
  late Position position;

  Future<void> getLatLon() async {
    final LocationPermission locationPermission =
        await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      debugPrint(locationPermission.toString());
      futureGeo = await getCityByName("London");
    } else {
      futureGeo = null;
      position = await Geolocator.getCurrentPosition();
    }
  }

  Future<CurrentWeather> getCurrentWeather() async {
    await getLatLon();
    final lat = futureGeo?[0].lat ?? position.latitude;
    final lon = futureGeo?[0].lon ?? position.longitude;

    final Map<String, dynamic> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric',
    };

    final response = await http.get(
      Uri.http("api.openweathermap.org", "data/2.5/weather", queryParams),
    );

    if (response.statusCode == 200) {
      debugPrint("OK Weather");
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed ${response.body}");
    }
  }

  Future<Forecast> getForecast() async {
    await getLatLon();
    final lat = futureGeo?[0].lat ?? position.latitude;
    final lon = futureGeo?[0].lon ?? position.longitude;

    final Map<String, dynamic> queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': 'metric',
    };

    final response = await http.get(
      Uri.http("api.openweathermap.org", "data/2.5/forecast", queryParams),
    );

    if (response.statusCode == 200) {
      debugPrint("OK Weather");
      return Forecast.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed ${response.body}");
    }
  }
}
