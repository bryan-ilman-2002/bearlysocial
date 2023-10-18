import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/main.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final TextEditingController userInputController;
  final String? hint;
  final Map<String, dynamic> map;
  final bool? enableFilter;
  final IconData? trailingIcon;

  const Dropdown({
    super.key,
    required this.userInputController,
    this.hint,
    required this.map,
    this.enableFilter,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry> entries = <DropdownMenuEntry>[];

    map.forEach((key, value) {
      entries.add(
        DropdownMenuEntry(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(appTextStyle),
            foregroundColor: MaterialStatePropertyAll(moderateGray),
          ),
          value: value,
          label: key,
        ),
      );
    });

    return DropdownMenu(
      controller: userInputController,
      hintText: hint ?? 'Tap here.',
      dropdownMenuEntries: entries,
      enableFilter: enableFilter ?? false,
      requestFocusOnTap: enableFilter,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: moderateGray,
          ),
        ),
      ),
      trailingIcon: Icon(trailingIcon),
    );
  }
}
