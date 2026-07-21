import 'package:flutter/material.dart';
import 'package:weather_app/screen/home_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          bodySmall: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}