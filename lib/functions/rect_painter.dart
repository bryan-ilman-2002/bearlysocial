import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BoundingBoxPainter extends CustomPainter {
  final Face detectedFace;

  BoundingBoxPainter({required this.detectedFace});

  @override
  void paint(final Canvas canvas, final Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final double left = detectedFace.boundingBox.left;
    final double top = detectedFace.boundingBox.top;
    final double right = detectedFace.boundingBox.right;
    final double bottom = detectedFace.boundingBox.bottom;

    canvas.drawRect(
      Rect.fromLTRB(left, top, right, bottom),
      paint,
    );
  }

  @override
  bool shouldRepaint(final BoundingBoxPainter oldDelegate) {
    return oldDelegate.detectedFace != detectedFace;
  }
}
