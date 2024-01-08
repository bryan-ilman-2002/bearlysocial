import 'package:bearlysocial/api_call/enums/endpoint.dart';
import 'package:bearlysocial/base_designs/pages/pre_auth.dart';
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
      url: Endpoint.signUp,
      exclamation: 'Get onboard!',
      question: 'Already have an account?',
      action: 'Sign in instead!',
    );
  }
}
