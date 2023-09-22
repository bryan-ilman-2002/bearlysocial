import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/generic/widgets/lines/horizontal_thin_line.dart';
import 'package:flutter/material.dart';

class AccountRecovery extends StatefulWidget {
  const AccountRecovery({super.key});

  @override
  State<AccountRecovery> createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _emailTextFieldController =
      TextEditingController();

  bool _submitted = false;
  bool _emailIsValid = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  void checkEmail() {
    setState(() {
      String email = _emailTextFieldController.text;
      final RegExp regex = RegExp(
          r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (regex.hasMatch(email)) {
        _submitted = true;
      } else {
        _emailIsValid = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  color: moderateGray,
                ),
              ),
            ),
            Text(
              'Account Recovery',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: heavyGray,
              ),
            ),
          ],
        ),
        const HorizontalThinLine(
          horizontalMargin: 0,
        ),
        const SizedBox(
          height: 12,
        ),
        if (!_submitted)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              children: [
                TextField(
                  focusNode: _emailFocusNode,
                  controller: _emailTextFieldController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: _emailFocusNode.hasFocus
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color:
                          _emailFocusNode.hasFocus ? heavyGray : moderateGray,
                    ),
                    errorText:
                        _emailIsValid ? null : 'Please enter a valid email.',
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
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'To secure your account, please provide your associated email. '
                  'A password reset link will be sent to this email. '
                  'Follow the link to reset your password.',
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ColoredButton(
                    width: 128,
                    verticalPadding: 16,
                    buttonColor: heavyGray,
                    basicBorderRadius: 16,
                    callbackFunction: checkEmail,
                    borderColor: Colors.transparent,
                    buttonShadow: moderateShadow,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: heavyGray,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'We have sent a link to reset your password to your email. '
                  'Please check your inbox for our message. '
                  'If you do not see it in your inbox, we recommend checking your spam or junk folder as well.',
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
