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
  late CurrentWeather futureWeather;
  bool isLoading = false;
  final Widgets widgets = Widgets();
  late SvgPicture svgIcon;

  Future refreshPage() async {
    setState(() {
      isLoading = true;
      debugPrint("loading");
    });
    futureWeather = await getCurrentWeather();
    //svgIcon = await widgets.iconBasedOnWeather();
    setState(() {
      isLoading = false;
      debugPrint("not loading");
    });
  }

  @override
  void initState() {
    refreshPage();
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
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
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
                        futureWeather.name,
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                ),
                //Positioned(child: Container(child: svgIcon))
              ],
            );
          }
        },
      ),
    );
  }
}
