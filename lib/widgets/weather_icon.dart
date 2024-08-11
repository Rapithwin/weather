import 'dart:developer';

import 'package:flutter/material.dart';

class Widgets {
  bool isDayTime(int sunrise, int sunset, int currentTime) {
    return currentTime >= sunrise && currentTime <= sunset;
  }

  Widget iconBasedOnWeather(int weatherId, int sunrise, int sunset,
      {required int currentTime}) {
    if (isDayTime(sunrise, sunset, currentTime)) {
      log("Day");
    } else {
      log("Night");
    }

    //debugPrint(localFormatted);

    switch (weatherId) {
      case >= 200 && < 300:
        // Thunderstorm

        return Image.asset("assets/icons/thunderstomr.png");
      case >= 300 && < 400:
        // Drizzle
        return Image.asset("assets/icons/drizzle.png");
      case >= 500 && < 600:
        // Rain
        return Image.asset("assets/icons/rain.png");

      case >= 600 && < 700:
        return Image.asset("assets/icons/snow.png");

      case >= 700 && < 800:
        debugPrint("Atmosphere");
      case 800:
        if (isDayTime(sunrise, sunset, currentTime)) {
          return Image.asset("assets/icons/clear_day.png");
        } else {
          return Image.asset("assets/icons/clear_night.png");
        }

      case > 800 && < 900:
        return Image.asset("assets/icons/cloudy.png");
    }

    return Text(weatherId.toString());
  }
}
