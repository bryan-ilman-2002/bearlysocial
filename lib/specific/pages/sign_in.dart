import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/pages/pre_auth_page.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  final Function(int) onTap;

  const SignIn({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreAuthenticationPage(
      onTap: onTap,
      thisIsSignUp: false,
      url: API.signIn,
      exclamation: 'Welcome Back!',
      question: 'Don\'t have an account?',
      action: 'Sign up first!',
    );
  }
}
