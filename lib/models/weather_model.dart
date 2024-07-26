class CurrentWeather {
  List<Weather> weather;
  Main main;
  int visibility;
  Wind wind;
  Rain? rain;
  int dt;
  Sys sys;
  int timezone;
  String name;

  CurrentWeather({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    this.rain,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.name,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromJson(json["wind"]),
        rain: json["rain"],
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "visibility": visibility,
        "wind": wind.toJson(),
        "rain": rain?.toJson(),
        "dt": dt,
        "sys": sys.toJson(),
        "timezone": timezone,
        "name": name,
      };
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class Rain {
  double the1H;

  Rain({
    required this.the1H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "1h": the1H,
      };
}

class Sys {
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Weather {
  int id;
  String main;
  String description;

  Weather({
    required this.id,
    required this.main,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
      };
}

class Wind {
  double speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
