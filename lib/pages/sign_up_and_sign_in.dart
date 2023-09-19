import 'package:bearlysocial/functions/getters/app_colors.dart';
import 'package:bearlysocial/functions/getters/app_shadows.dart';
import 'package:bearlysocial/widgets/buttons/colored_btn.dart';
import 'package:flutter/material.dart';

class SignUpAndSignIn extends StatefulWidget {
  const SignUpAndSignIn({super.key});

  @override
  State<SignUpAndSignIn> createState() => _SignUpAndSignInState();
}

class _SignUpAndSignInState extends State<SignUpAndSignIn> {
  bool _obscureText = true;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    usernameFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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
                Row(
                  children: [
                    Expanded(
                      flex: 75,
                      child: Text(
                        'Welcome back!',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: heavyGray,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 25,
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                TextField(
                  focusNode: usernameFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: usernameFocusNode.hasFocus
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color:
                          usernameFocusNode.hasFocus ? heavyGray : moderateGray,
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
                  height: 32,
                ),
                TextField(
                  obscureText: _obscureText,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: passwordFocusNode.hasFocus
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color:
                          passwordFocusNode.hasFocus ? heavyGray : moderateGray,
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
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(
                        top: 16,
                      ),
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: passwordFocusNode.hasFocus
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
                  height: 8,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: ColoredButton(
                    width: 128,
                    verticalPadding: 4,
                    basicBorderRadius: 128,
                    buttonColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ColoredButton(
                  width: double.infinity,
                  verticalPadding: 16,
                  buttonColor: heavyGray,
                  basicBorderRadius: 16,
                  borderColor: Colors.transparent,
                  buttonShadow: moderateShadow,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(),
                    ),
                    ColoredButton(
                      width: 112,
                      verticalPadding: 4,
                      basicBorderRadius: 128,
                      buttonColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      child: Text(
                        'Sign up instead!',
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
