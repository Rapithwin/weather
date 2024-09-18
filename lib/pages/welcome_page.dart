import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/request_permission.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Constants.lightBlue,
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -130,
              top: 0,
              child: Image.asset(
                "assets/images/cloud3.png",
                color: Colors.white38,
                height: 450,
                width: 450,
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: size.width,
                height: size.height / 2,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width - 50,
                      child: Text(
                        "Get weather information and forcasts when and how you want them.",
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.24,
                      child: Image.asset(
                        "assets/images/clear.png",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        requestLocation().then(
                          (_) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                        ).onError(
                          (error, _) {
                            log(error.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(180, 50),
                        backgroundColor: Constants.darkBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Get Started",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Constants.whiteColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Constants.whiteColor,
                              size: 19,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
