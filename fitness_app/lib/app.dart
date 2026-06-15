import 'package:flutter/material.dart';
import 'package:fitness_app/screens/main_page.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.greenAccent,
          surface: Colors.grey.shade900,
        ),
      ),
      home: const MainPage(),
    );
  }
}
