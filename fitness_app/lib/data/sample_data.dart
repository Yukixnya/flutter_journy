import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/goal.dart';

final List<Workout> sampleWorkouts = [
  Workout(
    name: 'Morning Run',
    duration: '1 min',
    calories: 320,
    icon: Icons.directions_run,
    exercises: [
      'Warm-up jog',
      'Interval sprints',
      'Steady pace run',
      'Cool-down walk',
    ],
  ),
  Workout(
    name: 'HIIT Training',
    duration: '25 min',
    calories: 400,
    icon: Icons.fitness_center,
    exercises: [
      'Burpees',
      'Jump squats',
      'Mountain climbers',
      'High knees',
      'Plank jacks',
    ],
  ),
  Workout(
    name: 'Yoga Flow',
    duration: '45 min',
    calories: 180,
    icon: Icons.self_improvement,
    exercises: [
      'Sun salutation',
      'Warrior pose',
      'Tree pose',
      'Downward dog',
      'Child\'s pose',
    ],
  ),
  Workout(
    name: 'Weight Training',
    duration: '50 min',
    calories: 350,
    icon: Icons.sports_gymnastics,
    exercises: [
      'Bench press',
      'Deadlifts',
      'Shoulder press',
      'Bicep curls',
      'Tricep dips',
    ],
  ),
  Workout(
    name: 'Cycling',
    duration: '40 min',
    calories: 280,
    icon: Icons.directions_bike,
    exercises: [
      'Flat terrain ride',
      'Hill climb intervals',
      'Speed sprints',
      'Cool-down pedal',
    ],
  ),
];

final List<Goal> sampleGoals = [
  Goal(
    name: 'Steps',
    currentValue: 4500,
    targetValue: 10000,
    unit: 'steps',
  ),
  Goal(
    name: 'Calories',
    currentValue: 1200,
    targetValue: 2000,
    unit: 'kcal',
  ),
  Goal(
    name: 'Water',
    currentValue: 7,
    targetValue: 8,
    unit: 'glasses',
  ),
  Goal(
    name: 'Sleep',
    currentValue: 6,
    targetValue: 8,
    unit: 'hours',
  ),
];
