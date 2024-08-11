import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/constants.dart';
import 'package:weather/models/forecast_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/widgets/forecast_row.dart';
import 'package:weather/widgets/my_drawer.dart';
import 'package:weather/widgets/weather_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrentWeather> futureWeather;
  late Future<Forecast> futureForecast;
  bool isLoading = false;
  final Widgets widgets = Widgets();
  late Widget svgIcon;
  late Widget backgroundColor;
  final weatherApi = WeatherAPI();
  final DateTime nowUtc = DateTime.now().toUtc();

  @override
  void initState() {
    futureWeather = weatherApi.getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor:
          Constants.lightBlue, // TODO: Will depend on the time of the day.
      body: Stack(
        children: [
          FutureBuilder(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Data"),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("null"),
                );
              } else {
                final sunrise = snapshot.data!.sys.sunrise;
                final sunset = snapshot.data!.sys.sunset;
                final timeShift = snapshot.data!.timezone;
                final weatherId = snapshot.data!.weather[0].id;

                final localTime = nowUtc.add(Duration(seconds: timeShift));
                final localUnix = localTime.millisecondsSinceEpoch ~/ 1000;

                return Stack(
                  children: <Widget>[
                    Positioned(
                      left: size.width * 0.3,
                      top: 60,
                      child: Text(
                        snapshot.data!.name,
                        style: textTheme.titleLarge,
                      ),
                    ),
                    // Icon
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child: Container(
                        child: widgets.iconBasedOnWeather(
                          weatherId,
                          sunrise,
                          sunset,
                          currentTime: localUnix,
                        ),
                      ),
                    ),
                    // Temperature
                    Positioned(
                      top: size.height * 0.50,
                      left: 30,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${snapshot.data!.main.temp.round().toString()}°",
                            style: textTheme.headlineLarge?.copyWith(
                              fontSize: 95,
                            ),
                          ),
                          Text(
                            "Feels Like: ${snapshot.data?.main.feelsLike.round()}°",
                            style: textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.597,
                      right: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data!.weather[0].description,
                            style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                          ),
                          Text(
                            "H:${snapshot.data!.main.tempMax.round()}° | L:${snapshot.data!.main.tempMin.round()}°",
                            style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                          ),
                          Text(
                            "Humidity: ${snapshot.data!.main.humidity}%",
                            style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      bottom: 40,
                      left: 10,
                      right: 10,
                      child: ForecastRow(),
                    )
                  ],
                );
              }
              return const Center(
                child: Text("Connection error"),
              );
            },
          ),
          const DrawerIcon(),
        ],
      ),
    );
  }
}
