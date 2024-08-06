import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Constants.lightBlue,
      appBar: AppBar(
        backgroundColor: Constants.lightBlue,
        title: Text("Settings", style: textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "Location access",
                style: textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
              subtitle: const Text("Change location permission settings"),
              leading: const Icon(Icons.location_on),
              onTap: () async {
                await Geolocator.openLocationSettings();
              },
            ),
            ListTile(
              title: Text(
                "Unit",
                style: textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
              subtitle: const Text("Change the temperature scale"),
              leading: const Icon(Icons.sunny),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
