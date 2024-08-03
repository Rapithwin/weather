import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/models/weather_model.dart';

class Widgets {
  late int sunrise;
  late int sunset;
  late int timeShift;
  final weatherApi = WeatherAPI();

  Future<Widget> iconBasedOnWeather() async {
    final CurrentWeather currentWeather = await weatherApi.getCurrentWeather();
    sunrise = currentWeather.sys.sunrise;
    sunset = currentWeather.sys.sunset;
    timeShift = currentWeather.timezone;

    final DateTime nowUtc = DateTime.now().toUtc();
    final DateTime localTime = nowUtc.add(Duration(seconds: timeShift));
    final localFormatted = DateFormat("Hm").format(localTime);

    debugPrint(localFormatted);

    switch (currentWeather.weather[0].id) {
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
        return Image.asset("assets/icons/clear_day.png");

      case > 800 && < 900:
        return Image.asset("assets/icons/cloudy.png");
    }
    debugPrint(currentWeather.weather[0].description);

    return Image.asset(
      "assets/icons/rain.png",
    );
  }

  // Future<Widget> currentTime() async {
  //   final CurrentWeather currentWeather = await getCurrentWeather();
  //   final DateTime sunrise =
  //       DateTime.fromMillisecondsSinceEpoch(currentWeather.sys.sunrise * 1000);
  //   final DateTime sunset =
  //       DateTime.fromMillisecondsSinceEpoch(currentWeather.sys.sunset * 1000);
  //   final timeShift = currentWeather.timezone;

  //   final DateTime nowUtc = DateTime.now().toUtc();
  //   final DateTime localTime = nowUtc.add(Duration(seconds: timeShift));
  //   final int sunriseCompare = localTime.compareTo(sunrise);
  //   final int sunsetCompare = localTime.compareTo(sunset);

  //   final localFormatted = DateFormat("Hm").format(localTime);

  //   if (sunriseCompare < 0 && sunsetCompare >= 0) {
  //     log(localFormatted.toString());
  //     return Text("Day");
  //   } else {
  //     log(localFormatted.toString());

  //     return Text("Night");
  //   }
  // }
}
