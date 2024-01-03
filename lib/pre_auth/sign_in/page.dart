import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/pre_auth/base_page.dart';
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
      url: API.signIn,
      exclamation: 'Welcome Back!',
      question: 'Don\'t have an account?',
      action: 'Sign up first!',
    );
  }
}
