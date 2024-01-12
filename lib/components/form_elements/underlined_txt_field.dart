import 'package:bearlysocial/constants/design_tokens.dart';
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
    this.errorText,
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
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              height: 0.8,
              fontWeight: widget.focusNode.hasFocus
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: widget.focusNode.hasFocus
                  ? Theme.of(context).focusColor
                  : Theme.of(context).textTheme.titleLarge?.color,
            ),
        errorText: widget.errorText,
        errorStyle: Theme.of(context).textTheme.bodySmall,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.heavyRed,
            width: ThicknessSize.small,
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
            color: Theme.of(context).dividerColor,
            width: ThicknessSize.small,
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
                      : Theme.of(context).dividerColor,
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
