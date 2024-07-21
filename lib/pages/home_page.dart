import 'package:flutter/material.dart';
import 'package:weather/api/geocoding_api.dart';
import 'package:weather/models/geocoding_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Geocoding> futureCity;

  @override
  void initState() {
    super.initState();
    getCityByName("Tehran").then((value) => futureCity = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCityByName("Tehran"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(futureCity[0].name!),
            );
          }
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
