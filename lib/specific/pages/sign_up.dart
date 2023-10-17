import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/pages/pre_auth_page.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final Function(int) onTap;

  const SignUp({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreAuthenticationPage(
      onTap: onTap,
      enableAccountRecovery: true,
      url: API.signUp,
      exclamation: 'Get onboard!',
      question: 'Already have an account?',
      action: 'Sign in instead!',
    );
  }
}
