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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Constants.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
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
