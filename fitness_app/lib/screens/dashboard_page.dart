import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/activity_ring.dart';
import 'package:fitness_app/widgets/stat_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardsController;
  late Animation<RelativeRect> _leftCardAnim;
  late Animation<RelativeRect> _centerCardAnim;
  late Animation<RelativeRect> _rightCardAnim;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.forward();

    _cardsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardsController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final cardWidth = (totalWidth / 3) - 8;
                  final startLeft = (totalWidth / 2) - (cardWidth / 2);
                  final startRight = startLeft;

                  final leftCardAnim = RelativeRectTween(
                    begin: RelativeRect.fromLTRB(startLeft, 0, startRight, 0),
                    end: RelativeRect.fromLTRB(0, 0, totalWidth - cardWidth, 0),
                  ).animate(CurvedAnimation(
                      parent: _cardsController, curve: Curves.easeOutCubic));

                  final centerCardAnim = RelativeRectTween(
                    begin: RelativeRect.fromLTRB(startLeft, 0, startRight, 0),
                    end: RelativeRect.fromLTRB(
                        cardWidth + 12, 0, cardWidth + 12, 0),
                  ).animate(CurvedAnimation(
                      parent: _cardsController, curve: Curves.easeOutCubic));

                  final rightCardAnim = RelativeRectTween(
                    begin: RelativeRect.fromLTRB(startLeft, 0, startRight, 0),
                    end: RelativeRect.fromLTRB(totalWidth - cardWidth, 0, 0, 0),
                  ).animate(CurvedAnimation(
                      parent: _cardsController, curve: Curves.easeOutCubic));

                  return SizedBox(
                    height: 125,
                    child: Stack(
                      children: [
                        PositionedTransition(
                          rect: leftCardAnim,
                          child: const StatCard(
                            icon: Icons.directions_walk,
                            label: 'Steps',
                            value: '6,500',
                            color: Colors.greenAccent,
                            animationType: 'walk',
                          ),
                        ),
                        PositionedTransition(
                          rect: centerCardAnim,
                          child: const StatCard(
                            icon: Icons.location_on,
                            label: 'Distance',
                            value: '4.2 km',
                            color: Colors.orangeAccent,
                            animationType: 'tilt',
                          ),
                        ),
                        PositionedTransition(
                          rect: rightCardAnim,
                          child: const StatCard(
                            icon: Icons.favorite,
                            label: 'Heart',
                            value: '72 bpm',
                            color: Colors.redAccent,
                            animationType: 'beat',
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
              AnimatedBuilder(
                animation: _animationController,
                child: Card(
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
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0.30, 0), end: Offset.zero)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationController,
                child: Card(
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
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0.35, 0), end: Offset.zero)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animationController,
                child: Card(
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
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0.40, 0), end: Offset.zero)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
