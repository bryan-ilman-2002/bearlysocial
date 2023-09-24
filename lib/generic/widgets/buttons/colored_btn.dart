import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Function? callbackFunction;
  final Color buttonColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color borderColor;
  final double borderRadius;
  final BoxShadow? buttonShadow;
  final Widget? child;

  const ColoredButton({
    super.key,
    this.width,
    this.height,
    this.horizontalPadding,
    this.verticalPadding,
    this.callbackFunction,
    this.buttonColor = Colors.white,
    this.splashColor,
    this.splashFactory,
    this.borderColor = Colors.black,
    this.borderRadius = 8,
    this.buttonShadow,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: buttonShadow != null ? [buttonShadow!] : [],
      ),
      child: Material(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: () {
            if (callbackFunction != null) {
              callbackFunction!();
            }
          },
          splashFactory: splashFactory,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 0,
                vertical: verticalPadding ?? 0),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
