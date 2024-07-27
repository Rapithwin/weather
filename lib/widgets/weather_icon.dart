import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/models/weather_model.dart';

class Widgets {
  late int sunrise;
  late int sunset;
  late int timeShift;

  Future<SvgPicture> iconBasedOnWeather() async {
    final CurrentWeather currentWeather = await getCurrentWeather();
    sunrise = currentWeather.sys.sunrise;
    sunset = currentWeather.sys.sunset;
    timeShift = currentWeather.timezone;
    final int now = DateTime.now().toUtc().millisecondsSinceEpoch ~/
        Duration.millisecondsPerSecond;
    final int currentTime = now - (timeShift);
    final DateTime nowDt = DateTime.fromMillisecondsSinceEpoch(
        currentTime * Duration.millisecondsPerSecond);
    var format = DateFormat("Hm");
    debugPrint(format.format(nowDt));

    switch (currentWeather.weather[0].id) {
      case >= 200 && < 300:
        // Thunderstorm
        return SvgPicture.asset("assets/icons/clouds_thunderstorm.svg");
      case >= 300 && < 400:
        // Drizzle
        return SvgPicture.asset("assets/icons/cloud_drizzel.svg");
      case >= 500 && < 600:
        // Rain
        debugPrint("Rain");
      case >= 600 && < 700:
        debugPrint("Snow");
      case >= 700 && < 800:
        debugPrint("Atmosphere");
      case 800:
        debugPrint("Clear");
      case > 800 && < 900:
        debugPrint("Clouds");
    }
    debugPrint(currentWeather.weather[0].description);
    return SvgPicture.asset("assets/icons/clouds_thunderstorm.svg");
  }
}
