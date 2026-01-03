import 'package:flutter/material.dart';

import 'Pages/ChooseATripPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/PlanYourRidePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      home: MyHomePage(title: 'Uber UI Home Page'),
    );
  }
}

