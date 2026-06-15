import 'package:flutter/material.dart';
import 'package:fitness_app/data/sample_data.dart';
import 'package:fitness_app/widgets/workout_card.dart';
import 'package:fitness_app/screens/timer_page.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  final Set<int> _expandedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Workouts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: sampleWorkouts.length,
        itemBuilder: (context, index) {
          return WorkoutCard(
            workout: sampleWorkouts[index],
            isExpanded: _expandedIndices.contains(index),
            onTap: () {
              setState(() {
                if (_expandedIndices.contains(index)) {
                  _expandedIndices.remove(index);
                } else {
                  _expandedIndices.add(index);
                }
              });
            },
            onStartTimer: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TimerPage(
                    workout: sampleWorkouts[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
