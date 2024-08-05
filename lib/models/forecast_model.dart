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
            (x) => ForecastList.fromJson(x),
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
  String? dtText;
  Main main;
  List<Weather> weather;

  ForecastList({
    this.dt,
    this.dtText,
    required this.main,
    required this.weather,
  });

  factory ForecastList.fromJson(Map<String, dynamic> json) => ForecastList(
        dt: json['dt'],
        dtText: json['dt_txt'],
        main: Main.fromJson(json['main']),
        weather: List<Weather>.from(
          json['weather'].map(
            (x) => Weather.fromJson(x),
          ),
        ),
      );
}

class Main {
  double? temp;

  Main({
    this.temp,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'],
      );
}

class Weather {
  String? main;
  int? id;

  Weather({
    this.main,
    this.id,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json['main'],
        id: json['id'],
      );
}
