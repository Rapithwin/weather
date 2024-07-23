import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/geocoding_api.dart';
import 'package:weather/models/weather_model.dart';

final String apiKey = dotenv.env["API_KEY"]!;

Future<CurrentWeather> getCurrentWeather() async {
  final futureGeo = await getCityByName("London");
  final locationPermission = await Geolocator.checkPermission();

  // if (locationPermission == LocationPermission.denied ||
  //     locationPermission == LocationPermission.deniedForever ||
  //     locationPermission == LocationPermission.unableToDetermine) {}
  final lat = futureGeo[0].lat;
  final lon = futureGeo[0].lon;

  final Map<String, dynamic> queryParams = {
    'lat': lat.toString(),
    'lon': lon.toString(),
    'appid': apiKey,
  };

  final response = await http.get(
    Uri.http("api.openweathermap.org", "data/2.5/weather", queryParams),
  );

  if (response.statusCode == 200) {
    debugPrint("OK");
    return CurrentWeather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed ${response.body}");
  }
}
