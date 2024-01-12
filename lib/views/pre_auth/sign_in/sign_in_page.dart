import 'package:bearlysocial/base_designs/pages/pre_auth_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  final Function(int) onTap;

  const SignInPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreAuthenticationPage(
      onTap: onTap,
      accountCreation: false,
      exclamation: 'Welcome Back!',
      question: 'Don\'t have an account?',
      action: 'Sign up first!',
    );
  }
}
