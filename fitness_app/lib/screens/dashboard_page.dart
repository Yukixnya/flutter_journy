import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/activity_ring.dart';
import 'package:fitness_app/widgets/stat_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
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
              const Text(
                'Activity Rings',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ActivityRing(
                    label: 'Steps',
                    value: 0.65,
                    color: Colors.greenAccent,
                    size: 90,
                  ),
                  ActivityRing(
                    label: 'Calories',
                    value: 0.6,
                    color: Colors.orangeAccent,
                    size: 90,
                  ),
                  ActivityRing(
                    label: 'Active Min',
                    value: 0.5,
                    color: Colors.blueAccent,
                    size: 90,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Today\'s Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(
                    child: StatCard(
                      icon: Icons.directions_walk,
                      label: 'Steps',
                      value: '6,500',
                      color: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.location_on,
                      label: 'Distance',
                      value: '4.2 km',
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: StatCard(
                      icon: Icons.favorite,
                      label: 'Heart',
                      value: '72 bpm',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.directions_run, color: Colors.black),
                  ),
                  title: const Text(
                    'Morning Run',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    '30 min - Today',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.self_improvement, color: Colors.black),
                  ),
                  title: const Text(
                    'Yoga Flow',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    '45 min - Yesterday',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.fitness_center, color: Colors.black),
                  ),
                  title: const Text(
                    'HIIT Training',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    '20 min - 2 days ago',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
