class Forecast {
  List<ForecastList> list;
  City city;

  Forecast({
    required this.list,
    required this.city,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        list: List<ForecastList>.from(
          json['list'].map(
            (x) => Weather.fromJson(x),
          ),
        ),
        city: City.fromJson(
          json['city'],
        ),
      );
}

class City {
  int? sunrise;
  int? sunset;

  City({
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );
}

class ForecastList {
  int? dt;
  Main main;
  Weather weather;

  ForecastList({
    this.dt,
    required this.main,
    required this.weather,
  });

  factory ForecastList.fromJson(Map<String, dynamic> json) => ForecastList(
        dt: json['dt'],
        main: Main.fromJson(json['main']),
        weather: Weather.fromJson(
          json['weather'],
        ),
      );
}

class Main {
  double? temp;

  Main({
    this.temp,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(temp: json['temp']);
}

class Weather {
  String? main;

  Weather({
    this.main,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      Weather(main: json['main']);
}
