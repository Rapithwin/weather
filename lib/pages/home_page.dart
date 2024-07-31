import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/constants.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/widgets/weather_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrentWeather> futureWeather;
  final Widgets widgets = Widgets();
  late SvgPicture svgIcon;

  @override
  void initState() {
    futureWeather = getCurrentWeather();
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
                        width: size.width * 0.13,
                      ),
                      Text(
                        snapshot.data!.name,
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                //Positioned(child: Container(child: svgIcon))
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
