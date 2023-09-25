import 'dart:convert';

import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/enums/db_key.dart';
import 'package:bearlysocial/generic/functions/generate_hash.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:bearlysocial/generic/functions/make_request.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/generic/schemas/extra.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/specific/widgets/sheets/account_recovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashlib/hashlib.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';

class SignIn extends ConsumerStatefulWidget {
  final Function(int) onTap;

  const SignIn({
    super.key,
    required this.onTap,
  });

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  bool _obscureText = true;

  bool _inputIsBlocked = false;
  bool _passwordIsWrong = false;

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

  void _signIn() async {
    setState(() {
      _inputIsBlocked = true;

      _usernameIsValid = _usernameTextFieldController.text.isNotEmpty;
      _passwordIsValid = _passwordTextFieldController.text.isNotEmpty;
    });

    if (_usernameIsValid && _passwordIsValid) {
      String id = hash16(_usernameTextFieldController.text);
      String token = hash32(_passwordTextFieldController.text);

      final Response httpResponse =
          await makeRequest(API.signIn, {'id': id, 'token': token});

      if (mounted) {
        if (httpResponse.statusCode == 200) {
          final Isar? dbConnection = Isar.getInstance();

          final Extra savedId = Extra()
            ..key = crc32code(DatabaseKey.id.string)
            ..value = id;

          final Extra savedMainAccessNumber = Extra()
            ..key = crc32code(DatabaseKey.mainAccessNumber.string)
            ..value = jsonDecode(httpResponse.body)['mainAccessNumber'];

          await dbConnection?.writeTxn(() async {
            await dbConnection.extras.put(savedId);
            await dbConnection.extras.put(savedMainAccessNumber);
          });

          setState(() {
            _passwordIsWrong = false;
            _inputIsBlocked = false;
          });

          ref.watch(enterApp)();
        } else {
          setState(() {
            _passwordIsWrong = true;
            _inputIsBlocked = false;
          });
        }
      }
    } else {
      setState(() {
        _inputIsBlocked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                focusNode: _usernameFocusNode,
                controller: _usernameTextFieldController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: _usernameFocusNode.hasFocus
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color:
                        _usernameFocusNode.hasFocus ? heavyGray : moderateGray,
                  ),
                  errorText:
                      _usernameIsValid ? null : 'Username cannot be empty.',
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
                    color:
                        _passwordFocusNode.hasFocus ? heavyGray : moderateGray,
                  ),
                  errorText: _passwordIsValid
                      ? _passwordIsWrong
                          ? 'Password is wrong.'
                          : null
                      : 'Password cannot be empty.',
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
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return const AccountRecovery();
                      },
                    );
                  },
                  child: const Text(
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
                borderRadius: 16,
                callbackFunction: _inputIsBlocked
                    ? null
                    : () {
                        _signIn();
                      },
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
                        'Sign In',
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
                    'Don\'t have an account?',
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onTap(0);
                    },
                    child: Text(
                      'Sign up first!',
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
    );
  }
}
