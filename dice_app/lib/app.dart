import 'package:flutter/material.dart';
import 'package:dice_app/screens/dice_roll_homepage.dart';

class DiceRoll extends StatelessWidget{
  const DiceRoll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DiceRoll",
      home: DiceRollHomepage(),
    );
  }
}