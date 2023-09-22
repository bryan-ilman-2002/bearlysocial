import 'dart:convert';

import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/functions/generate_hash.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:bearlysocial/generic/functions/make_request.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function(int) onTap;

  const SignUp({
    super.key,
    required this.onTap,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;

  bool _inputIsBlocked = false;
  bool _usernameIsTaken = false;

  bool _usernameIsValid = true;
  bool _passwordIsValid = true;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _usernameTextFieldController =
      TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _signUp() {
    setState(() {
      _inputIsBlocked = true;

      _usernameIsValid = _usernameTextFieldController.text.isNotEmpty;
      _passwordIsValid = _passwordTextFieldController.text.isNotEmpty;

      if (_usernameIsValid && _passwordIsValid) {
        String id = hash16(_usernameTextFieldController.text);
        String token = hash32(_passwordTextFieldController.text);

        makeRequest(API.signUp, {'id': id, 'token': token}).then((response) {
          if (mounted) {
            setState(() {
              if (response.statusCode == 200) {
                _usernameIsTaken = false;
                print(jsonDecode(response.body));
              } else {
                _usernameIsTaken = true;
                print(jsonDecode(response.body));
              }

              _inputIsBlocked = false;
            });
          }
        });
      } else {
        _inputIsBlocked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bearlysocial.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      lightShadow,
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Get onboard!',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: heavyGray,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextField(
                  focusNode: _usernameFocusNode,
                  controller: _usernameTextFieldController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: _usernameFocusNode.hasFocus
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _usernameFocusNode.hasFocus
                          ? heavyGray
                          : moderateGray,
                    ),
                    errorText: _usernameIsValid
                        ? _usernameIsTaken
                            ? 'Username is already taken.'
                            : null
                        : 'Username cannot be empty.',
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
                  height: 32,
                ),
                TextField(
                  obscureText: _obscureText,
                  focusNode: _passwordFocusNode,
                  controller: _passwordTextFieldController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: _passwordFocusNode.hasFocus
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _passwordFocusNode.hasFocus
                          ? heavyGray
                          : moderateGray,
                    ),
                    errorText:
                        _passwordIsValid ? null : 'Password cannot be empty.',
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
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(
                        top: 16,
                      ),
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: _passwordFocusNode.hasFocus
                            ? heavyGray
                            : moderateGray,
                      ),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                ColoredButton(
                  width: double.infinity,
                  verticalPadding: 16,
                  buttonColor: heavyGray,
                  basicBorderRadius: 16,
                  callbackFunction: _inputIsBlocked ? null : _signUp,
                  borderColor: Colors.transparent,
                  buttonShadow: moderateShadow,
                  child: _inputIsBlocked
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onTap(1);
                      },
                      child: Text(
                        'Sign in instead!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: heavyGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
