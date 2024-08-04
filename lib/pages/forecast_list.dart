import 'package:flutter/material.dart';
import 'package:weather/models/forecast_model.dart';

class ForecastRow extends StatefulWidget {
  final Future<Forecast> forecastFuture;
  const ForecastRow({super.key, required this.forecastFuture});

  @override
  State<ForecastRow> createState() => _ForecastRowState();
}

class _ForecastRowState extends State<ForecastRow> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.forecastFuture,
      builder: (context, snapshot) {
        return const Placeholder();
      },
    );
  }
}
