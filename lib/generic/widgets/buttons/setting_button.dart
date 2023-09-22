import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? splashColor;
  final Color? buttonColor;
  final Color? iconColor;
  final Color? labelColor;
  final double borderRadius;

  const SettingButton({
    super.key,
    required this.icon,
    required this.label,
    this.splashColor,
    this.buttonColor,
    this.iconColor,
    this.labelColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: labelColor,
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: iconColor,
          ),
        ],
      ),
    );

    return Material(
      color: buttonColor ?? Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: () {},
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: content,
      ),
    );
  }
}
