import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/generic/widgets/form_elements/board.dart';
import 'package:bearlysocial/generic/widgets/form_elements/dropdown.dart';
import 'package:bearlysocial/generic/widgets/buttons/tag.dart';
import 'package:flutter/material.dart';

class Selector extends StatelessWidget {
  final TextEditingController userInputController;
  final String? hint;
  final Map<String, dynamic> map;
  final bool? enableFilter;
  final IconData? trailingIcon;
  final Function callbackFunction;
  final List<Tag>? tags;

  const Selector({
    super.key,
    required this.userInputController,
    this.hint,
    required this.map,
    this.enableFilter,
    this.trailingIcon,
    required this.callbackFunction,
    this.tags,
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
              enableFilter: enableFilter,
              trailingIcon: trailingIcon,
            ),
            const SizedBox(
              width: 2,
            ),
            ColoredButton(
              width: 58,
              height: 58,
              callbackFunction: callbackFunction,
              buttonColor: heavyGray,
              borderColor: Colors.transparent,
              uniformBorderRadius: 128,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Board(
          children: tags,
        ),
      ],
    );
  }
}
