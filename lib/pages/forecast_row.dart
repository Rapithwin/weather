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
          return ListView.builder(
            itemCount: snapshot.data!.list.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Constants.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("Connection error"),
        );
      },
    );
  }
}
