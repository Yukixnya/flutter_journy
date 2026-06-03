import 'package:flutter/material.dart';
import 'screens/my_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'demox',
        home: MyHomePage(),
      );
    }
}