import 'package:bearlysocial/components/lines/horizontal_line.dart';
import 'package:bearlysocial/constants.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() callbackFunction;
  final Color? splashColor;
  final Color? contentColor;

  const SettingButton({
    super.key,
    required this.icon,
    required this.label,
    required this.callbackFunction,
    this.splashColor,
    this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CurvatureSize.small),
          ),
          child: InkWell(
            onTap: callbackFunction.call,
            splashColor: splashColor,
            borderRadius: BorderRadius.circular(CurvatureSize.small),
            child: Padding(
              padding: const EdgeInsets.all(
                PaddingSize.medium,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: contentColor,
                  ),
                  const SizedBox(
                    width: WhiteSpaceSize.small,
                  ),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: contentColor,
                          ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: contentColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        const HorizontalLine(
          height: 0.12,
          horizontalMargin: MarginSize.medium,
        ),
      ],
    );
  }
}
