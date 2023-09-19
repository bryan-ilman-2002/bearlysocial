import 'package:bearlysocial/functions/getters/app_colors.dart';
import 'package:flutter/material.dart';

class HorizontalThinLine extends StatelessWidget {
  final double width;
  final double height;
  final double horizontalMargin;
  final double verticalMargin;
  final Color? lineColor;

  const HorizontalThinLine({
    super.key,
    this.width = double.infinity,
    this.horizontalMargin = 8,
    this.verticalMargin = 0,
    this.height = 0.2,
    this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      width: width,
      height: height,
      color: lineColor ?? heavyGray,
    );
  }
}
