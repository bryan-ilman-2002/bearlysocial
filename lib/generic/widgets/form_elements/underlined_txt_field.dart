import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:flutter/material.dart';

class UnderlinedTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode node;
  final bool textIsvalid;
  final bool textIsError;
  final String invalidText;
  final String errorText;

  const UnderlinedTextField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.controller,
    required this.node,
    required this.textIsvalid,
    required this.textIsError,
    required this.invalidText,
    required this.errorText,
  });
  @override
  State<UnderlinedTextField> createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText ? _obscureText : false,
      focusNode: widget.node,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight:
              widget.node.hasFocus ? FontWeight.bold : FontWeight.normal,
          color: widget.node.hasFocus ? heavyGray : heavyGray,
        ),
        errorText: widget.textIsError
            ? widget.errorText
            : widget.textIsvalid
                ? null
                : widget.invalidText,
        errorStyle: TextStyle(
          fontSize: 12,
          color: moderateRed,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: moderateRed,
            width: 1.6,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: moderateRed,
            width: 1.6,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: moderateGray,
            width: 0.4,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: heavyGray,
            width: 1.6,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: widget.obscureText
            ? IconButton(
                padding: const EdgeInsets.only(
                  top: 16,
                ),
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.node.hasFocus ? heavyGray : moderateGray,
                ),
                splashColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
