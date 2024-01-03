import 'package:bearlysocial/constants.dart';
import 'package:flutter/material.dart';

class UnderlinedTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorText;

  const UnderlinedTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    required this.focusNode,
    required this.errorText,
  });
  @override
  State<UnderlinedTextField> createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
  bool _obscureState = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText ? _obscureState : false,
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontFamily: appFontFamily,
          fontSize: TextSize.large,
          fontWeight:
              widget.focusNode.hasFocus ? FontWeight.bold : FontWeight.normal,
          color: widget.focusNode.hasFocus
              ? AppColor.heavyGray
              : AppColor.moderateGray,
        ),
        errorText: widget.errorText,
        errorStyle: const TextStyle(
          fontFamily: appFontFamily,
          fontSize: TextSize.small,
          color: AppColor.heavyRed,
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.heavyRed,
            width: ThicknessSize.verySmall,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.heavyRed,
            width: ThicknessSize.medium,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: ThicknessSize.verySmall,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).focusColor,
            width: ThicknessSize.medium,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: widget.obscureText
            ? IconButton(
                padding: const EdgeInsets.only(
                  top: PaddingSize.small,
                ),
                icon: Icon(
                  _obscureState ? Icons.visibility : Icons.visibility_off,
                  color: widget.focusNode.hasFocus
                      ? Theme.of(context).focusColor
                      : Theme.of(context).primaryColor,
                ),
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _obscureState = !_obscureState;
                  });
                },
              )
            : null,
      ),
    );
  }
}
