import 'package:flutter/material.dart';
import 'package:fitness_app/models/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onAddProgress;

  const GoalCard({
    super.key,
    required this.goal,
    required this.onAddProgress,
  });

  @override
  Widget build(BuildContext context) {
    final double progress =
        (goal.currentValue / goal.targetValue).clamp(0.0, 1.0);

    final Color progressColor;
    if (progress > 0.7) {
      progressColor = Colors.green;
    } else if (progress > 0.4) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }

    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  goal.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${goal.currentValue.toInt()} / ${goal.targetValue.toInt()} ${goal.unit}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: LinearProgressIndicator(
            //     value: progress,
            //     minHeight: 8,
            //     color: progressColor,
            //     backgroundColor: Colors.grey.shade800,
            //   ),
            // ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: onAddProgress,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '+ Add Progress',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
