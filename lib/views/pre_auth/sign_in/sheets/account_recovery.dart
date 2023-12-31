import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/constants.dart';
import 'package:bearlysocial/components/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/base_designs/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:flutter/material.dart';

class AccountRecovery extends StatefulWidget {
  const AccountRecovery({super.key});

  @override
  State<AccountRecovery> createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();

  bool _submitted = false;
  String? _emailErrorText;

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

  void _checkEmail() {
    setState(() {
      final RegExp emailRegExp = RegExp(
          r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(_emailController.text)) {
        _submitted = true;
        _emailErrorText = null;
      } else {
        _emailErrorText = 'Please enter a valid email.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return app_bottom_sheet.BottomSheet(
      title: 'Account Recovery',
      content: _submitted
          ? Column(
              children: [
                Icon(
                  Icons.check_rounded,
                  size: IconSize.large,
                  color: Theme.of(context).focusColor,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Text(
                  'We have sent a link to reset your password to your email. '
                  'Please check your inbox for our message. '
                  'If you do not see it in your inbox, we recommend checking your spam or junk folder as well.',
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              children: [
                UnderlinedTextField(
                  label: 'Email',
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  errorText: _emailErrorText,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Text(
                  'To secure your account, please provide your associated email. '
                  'A password reset link will be sent to this email. '
                  'Follow the link to reset your password.',
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SplashButton(
                    width: SideSize.large,
                    verticalPadding: PaddingSize.small,
                    borderRadius: BorderRadius.circular(
                      CurvatureSize.large,
                    ),
                    callbackFunction: _checkEmail,
                    shadow: Shadow.medium,
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
