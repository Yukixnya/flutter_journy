import 'package:flutter/material.dart';
import 'package:fitness_app/data/sample_data.dart';
import 'package:fitness_app/widgets/workout_card.dart';
import 'package:fitness_app/screens/timer_page.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final Set<int> _expandedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Workouts', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        child: ListView.builder(
          itemCount: sampleWorkouts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: WorkoutCard(
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
                      builder: (context) =>
                          TimerPage(workout: sampleWorkouts[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
        builder: (context, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.15),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: child,
          );
        },
      ),
    );
  }
}
