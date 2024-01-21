import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';

class BlinkingDots extends StatelessWidget {
  final AnimationController controller;
  final String leadingText;
  final bool enabled;
  final TextStyle? textStyle;

  const BlinkingDots({
    super.key,
    required this.controller,
    required this.leadingText,
    this.enabled = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              leadingText,
              style: textStyle,
            ),
            if (enabled)
              ...List.generate(
                4,
                (index) => AnimatedOpacity(
                  opacity: controller.value > index * 0.25 ? 1.0 : 0.0,
                  duration: const Duration(
                    milliseconds: AnimationDuration.instant,
                  ),
                  child: Text(
                    '.',
                    style: textStyle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
