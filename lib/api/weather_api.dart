import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/geocoding_api.dart';
import 'package:weather/models/geocoding_model.dart';
import 'package:weather/models/weather_model.dart';

final String apiKey = dotenv.env["API_KEY"]!;

Future<CurrentWeather> getCurrentWeather() async {
  late List<Geocoding>? futureGeo;
  final LocationPermission locationPermission =
      await Geolocator.checkPermission();
  late Position position;

  if (locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.deniedForever) {
    debugPrint(locationPermission.toString());
    futureGeo = await getCityByName("London");
  } else {
    futureGeo = null;
    position = await Geolocator.getCurrentPosition();
  }
  final lat = futureGeo?[0].lat ?? position.latitude;
  final lon = futureGeo?[0].lon ?? position.longitude;

  final Map<String, dynamic> queryParams = {
    'lat': lat.toString(),
    'lon': lon.toString(),
    'appid': apiKey,
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
