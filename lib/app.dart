import 'package:flutter/material.dart';
import 'package:radar_clima/features/weather/presentation/screens/weather_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Radar Clima',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const WeatherHomeScreen(),
    );
  }
}
