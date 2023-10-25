import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/pages/pre_auth_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final Function(int) onTap;

  const SignUpPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreAuthenticationPage(
      onTap: onTap,
      accountCreation: true,
      url: API.signUp,
      exclamation: 'Get onboard!',
      question: 'Already have an account?',
      action: 'Sign in instead!',
    );
  }
}
