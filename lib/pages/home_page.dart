import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/constants.dart';
import 'package:weather/models/forecast_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/pages/forecast_row.dart';
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

  Future loadIcon() async {
    setState(() {
      isLoading = true;
    });
    svgIcon = await widgets.iconBasedOnWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    futureWeather = weatherApi.getCurrentWeather();
    loadIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:
          Constants.lightBlue, // TODO: Will depend on the time of the day.
      body: FutureBuilder(
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
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 60,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Constants.whiteColor.withOpacity(0.23),
                          ),
                          child: const Icon(Icons.menu),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.16,
                      ),
                      Text(
                        snapshot.data!.name,
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: Container(
                    child:
                        isLoading ? const CircularProgressIndicator() : svgIcon,
                  ),
                ),
                Positioned(
                  top: size.height * 0.57,
                  left: 20,
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
                  top: size.height * 0.645,
                  right: 120,
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
                      )
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 50,
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
    );
  }
}
