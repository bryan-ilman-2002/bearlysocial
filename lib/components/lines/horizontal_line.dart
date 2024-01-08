import 'package:bearlysocial/constants.dart';
import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final double width;
  final double height;
  final double? horizontalMargin;
  final double? verticalMargin;
  final Color? color;

  const HorizontalLine({
    super.key,
    this.width = SideSize.infinity,
    this.height = ThicknessSize.verySmall,
    this.horizontalMargin,
    this.verticalMargin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? MarginSize.zero,
        vertical: verticalMargin ?? MarginSize.zero,
      ),
      width: width,
      height: height,
      color: color ?? Theme.of(context).focusColor,
    );
  }
}
