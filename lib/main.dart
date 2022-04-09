import 'package:flutter/material.dart';
import 'package:shortly/src/app/constants.dart';
import 'package:shortly/src/app/pages/onboarding/onboarding_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: kBackGroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingView(),
    );
  }
}
