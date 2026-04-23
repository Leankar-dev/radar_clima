import 'package:flutter/material.dart';

class AuroraHalo extends StatelessWidget {
  final double size;
  final Color color;
  final int alpha;

  const AuroraHalo({
    super.key,
    required this.size,
    required this.color,
    required this.alpha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withAlpha(alpha), Colors.transparent],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
