import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/geocoding_model.dart';

final String apiKey = dotenv.env["API_KEY"]!;

Future<List<Geocoding>> getCityByName(String cityName) async {
  final queryParams = {
    'q': cityName,
    'limit': '5',
    'appid': apiKey,
  };

  final response = await http.get(
    Uri.http("api.openweathermap.org", "geo/1.0/direct", queryParams),
  );

  var jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    debugPrint("OK");
    return List<Geocoding>.from(
      jsonResponse.map(
        (x) => Geocoding.fromJson(x),
      ),
    );
  } else {
    throw Exception(" ${response.body}");
  }
}
