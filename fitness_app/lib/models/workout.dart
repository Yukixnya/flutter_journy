import 'package:flutter/material.dart';

class Workout {
  final String name;
  final String duration;
  final int calories;
  final IconData icon;
  final List<String> exercises;

  Workout({
    required this.name,
    required this.duration,
    required this.calories,
    required this.icon,
    required this.exercises,
  });
}
