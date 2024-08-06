import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: Constants.lightBlue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Constants.darkBlue,
            ),
            child: Text(
              "Weather",
              style:
                  textTheme.titleLarge?.copyWith(color: Constants.whiteColor),
            ),
          ),
          ListTile(
            title: const Text("Add City"),
            leading: const Icon(Icons.add),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Settings"),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
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
    );
  }
}
