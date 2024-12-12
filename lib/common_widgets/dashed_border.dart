import 'dart:ui';

import 'package:flutter/material.dart';

/// A customizable dash line border widget
///
/// @author: Godwin Mathias
class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double dashWidth;
  final double dashSpacing;
  final double strokeWidth;
  final BorderRadius? borderRadius;

  const DashedBorder({
    super.key,
    required this.child,
    this.color = Colors.black,
    this.dashWidth = 5.0,
    this.dashSpacing = 3.0,
    this.strokeWidth = 1.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        dashWidth: dashWidth,
        dashSpacing: dashSpacing,
        strokeWidth: strokeWidth,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpacing;
  final double strokeWidth;
  final BorderRadius? borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpacing,
    required this.strokeWidth,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect borderRect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: borderRadius?.topLeft ?? Radius.zero,
      topRight: borderRadius?.topRight ?? Radius.zero,
      bottomLeft: borderRadius?.bottomLeft ?? Radius.zero,
      bottomRight: borderRadius?.bottomRight ?? Radius.zero,
    );

    final Path path = Path()..addRRect(borderRect);

    final PathMetrics pathMetrics = path.computeMetrics();

    for (final PathMetric metric in pathMetrics) {
      double distance = 0.0;

      while (distance < metric.length) {
        final double nextDashEnd = distance + dashWidth;
        final bool isEndValid = nextDashEnd < metric.length;

        final Path dash = metric.extractPath(
          distance,
          isEndValid ? nextDashEnd : metric.length,
        );

        canvas.drawPath(dash, paint);
        distance += dashWidth + dashSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
