import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';

Color calculateRatingColor(double rating) {
  const Color startColor = AppColor.heavyRed;
  const Color middleColor = AppColor.heavyYellow;
  const Color endColor = AppColor.heavyGreen;

  final double normalizedRating = (rating - 0.0) / (5.0 - 0.0);

  const double firstStop = 0.5;
  const double secondStop = 1.0;

  Color? ratingColor;

  if (normalizedRating <= firstStop) {
    ratingColor = Color.lerp(
      startColor,
      middleColor,
      normalizedRating / firstStop,
    );
  } else {
    ratingColor = Color.lerp(
      middleColor,
      endColor,
      (normalizedRating - firstStop) / (secondStop - firstStop),
    );
  }

  return ratingColor ?? Colors.transparent;
}
