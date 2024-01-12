import 'package:flutter/material.dart';

Rect transformRectangle({
  required Rect rect,
  required Size imageSize,
  required Size previewSize,
}) {
  final double scaleX = previewSize.width / imageSize.height;
  final double scaleY = previewSize.height / imageSize.width;

  final double scale = scaleX > scaleY ? scaleX : scaleY;
  final Offset offset = Offset(
    (previewSize.width - imageSize.height * scale) / 2,
    (previewSize.height - imageSize.width * scale) / 2,
  );

  return Rect.fromLTWH(
    rect.left * scale + offset.dx,
    rect.top * scale + offset.dy,
    rect.width * scale,
    rect.height * scale,
  );
}
