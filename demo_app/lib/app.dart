import 'package:flutter/material.dart';
import 'screens/my_home_screen.dart';

class MyAPP extends StatelessWidget{
  const MyAPP({super.key}); // pass key for location
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      title: 'Hello World',
      home: MyHomePage(),
    ));
  }
}