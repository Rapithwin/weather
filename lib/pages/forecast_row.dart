import 'package:flutter/material.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/constants.dart';
import 'package:weather/models/forecast_model.dart';

class ForecastRow extends StatefulWidget {
  const ForecastRow({super.key});

  @override
  State<ForecastRow> createState() => _ForecastRowState();
}

class _ForecastRowState extends State<ForecastRow> {
  late Future<Forecast> futureForecast;
  final WeatherAPI weatherApi = WeatherAPI();

  @override
  void initState() {
    futureForecast = weatherApi.getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
            height: 150,
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
                        "TODAY",
                        style: textTheme.labelLarge,
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
