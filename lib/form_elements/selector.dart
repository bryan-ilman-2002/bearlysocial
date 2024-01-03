import 'package:bearlysocial/generic/functions/create_tag_list.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/design_tokens.dart';
import 'package:bearlysocial/buttons/splash_btn.dart';
import 'package:bearlysocial/form_elements/board.dart';
import 'package:bearlysocial/form_elements/dropdown.dart';
import 'package:flutter/material.dart';

class Selector extends StatelessWidget {
  final TextEditingController userInputController;
  final String? hint;
  final Map<String, dynamic> map;
  final IconData? trailingIcon;
  final Function callbackFunction;
  final List<String> labels;
  final dynamic type;

  const Selector({
    super.key,
    required this.userInputController,
    this.hint,
    required this.map,
    this.trailingIcon,
    required this.callbackFunction,
    required this.labels,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dropdown(
              userInputController: userInputController,
              hint: hint,
              map: map,
              trailingIcon: trailingIcon,
            ),
            const SizedBox(
              width: AppSpacing.extraSmall,
            ),
            SplashButton(
              width: 58,
              height: 58,
              callbackFunction: callbackFunction,
              buttonColor: heavyGray,
              borderColor: Colors.transparent,
              // uniformBorderRadius: 128,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        if (labels.isNotEmpty) const SizedBox(height: AppSpacing.verySmall),
        if (labels.isNotEmpty) const SizedBox(height: AppSpacing.verySmall),
        if (labels.isNotEmpty) const SizedBox(height: AppSpacing.verySmall),
        if (labels.isNotEmpty) const SizedBox(height: AppSpacing.verySmall),
        if (labels.isNotEmpty) const Text('Tap to remove.'),
        const SizedBox(
          height: AppSpacing.small,
        ),
        Board(
          children: createTagList(labels: labels, type: type),
        ),
        if (labels.isNotEmpty) const SizedBox(height: AppSpacing.medium),
      ],
    );
  }
}
