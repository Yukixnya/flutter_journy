import 'package:flutter/material.dart';
import 'package:fitness_app/models/goal.dart';
import 'package:fitness_app/data/sample_data.dart';
import 'package:fitness_app/widgets/goal_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<Goal> _goals;

  @override
  void initState() {
    super.initState();
    _goals = sampleGoals
        .map((g) => Goal(
              name: g.name,
              currentValue: g.currentValue,
              targetValue: g.targetValue,
              unit: g.unit,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade800,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Fitness User',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Member since Jan 2025',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'My Goals',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(_goals.length, (i) {
                return GoalCard(
                  goal: _goals[i],
                  onAddProgress: () {
                    setState(() {
                      final increment = _goals[i].targetValue * 0.1;
                      _goals[i].currentValue =
                          (_goals[i].currentValue + increment)
                              .clamp(0, _goals[i].targetValue);
                    });
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
