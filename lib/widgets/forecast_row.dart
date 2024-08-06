import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/constants.dart';
import 'package:weather/models/forecast_model.dart';
import 'package:weather/widgets/weather_icon.dart';

class ForecastRow extends StatefulWidget {
  const ForecastRow({super.key});

  @override
  State<ForecastRow> createState() => _ForecastRowState();
}

class _ForecastRowState extends State<ForecastRow> {
  late Future<Forecast> futureForecast;
  final WeatherAPI weatherApi = WeatherAPI();
  final Widgets widgets = Widgets();

  @override
  void initState() {
    futureForecast = weatherApi.getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return FutureBuilder(
      future: futureForecast,
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
          return SizedBox(
            height: 170,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 11,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.list.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Constants.whiteColor.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapshot.data!.list[index].dtText!.substring(5, 10),
                        style: textTheme.labelLarge,
                      ),
                      Text(
                        snapshot.data!.list[index].dtText!.substring(11, 16),
                        style: textTheme.labelLarge,
                      ),
                      SizedBox(
                        height: 90,
                        child: widgets.iconBasedOnWeather(
                            snapshot.data!.list[index].weather[0].id!),
                      ),
                      Text(
                        "${snapshot.data!.list[index].main.temp!.round().toString()}°",
                        style: textTheme.labelLarge?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text("Connection error"),
        );
      },
    );
  }
}
