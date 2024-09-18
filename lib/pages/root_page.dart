import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/pages/forecast_page.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/widgets/my_drawer.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 0; // For BottomNavigationBar
  final List<Widget> pages = [
    const HomePage(),
    const ForecastPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Constants.lightBlue,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Constants.lightBlue,
        selectedIndex: currentPageIndex,
        indicatorColor: Constants.darkBlue.withOpacity(0.15),
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.sunny), label: "Today"),
          NavigationDestination(
              icon: Icon(Icons.access_time), label: "Forecast"),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
    );
  }
}
