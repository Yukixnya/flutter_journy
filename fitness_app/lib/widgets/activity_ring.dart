import 'package:flutter/material.dart';

class ActivityRing extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final double size;

  const ActivityRing({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: value),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, animatedValue, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: animatedValue,
                      strokeWidth: 8,
                      color: color,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Text(
                    '${(animatedValue * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
