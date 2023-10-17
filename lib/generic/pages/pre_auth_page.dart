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
import 'package:bearlysocial/generic/widgets/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/specific/widgets/modals/account_recovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashlib/hashlib.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';

class PreAuthenticationPage extends ConsumerStatefulWidget {
  final Function(int) onTap;
  final bool enableAccountRecovery;
  final API url;
  final String exclamation;
  final String question;
  final String action;

  const PreAuthenticationPage({
    super.key,
    required this.onTap,
    required this.enableAccountRecovery,
    required this.url,
    required this.exclamation,
    required this.question,
    required this.action,
  });

  @override
  ConsumerState<PreAuthenticationPage> createState() =>
      _PreAuthenticationPageState();
}

class _PreAuthenticationPageState extends ConsumerState<PreAuthenticationPage> {
  bool _inputIsBlocked = false;
  bool _errorOccurred = false;

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

  void _authenticate() async {
    setState(() {
      _inputIsBlocked = true;

      _usernameIsValid = _usernameTextFieldController.text.isNotEmpty;
      _passwordIsValid = _passwordTextFieldController.text.isNotEmpty;
    });

    if (_usernameIsValid && _passwordIsValid) {
      String id = hash16(_usernameTextFieldController.text);
      String token = hash32(_passwordTextFieldController.text);

      final Response httpResponse =
          await makeRequest(widget.url, {'id': id, 'token': token});

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
            _errorOccurred = false;
            _inputIsBlocked = false;
          });

          ref.watch(enterApp)();
        } else {
          setState(() {
            _errorOccurred = true;
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
                      widget.exclamation,
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
              UnderlinedTextField(
                label: 'Username',
                obscureText: false,
                controller: _usernameTextFieldController,
                node: _usernameFocusNode,
                textIsvalid: _usernameIsValid,
                textIsError:
                    widget.enableAccountRecovery ? _errorOccurred : false,
                invalidText: 'Username cannot be empty.',
                errorText: widget.enableAccountRecovery
                    ? 'Username is already taken.'
                    : '',
              ),
              const SizedBox(
                height: 32,
              ),
              UnderlinedTextField(
                label: 'Password',
                obscureText: true,
                controller: _passwordTextFieldController,
                node: _passwordFocusNode,
                textIsvalid: _passwordIsValid,
                textIsError:
                    widget.enableAccountRecovery ? false : _errorOccurred,
                invalidText: 'Password cannot be empty.',
                errorText:
                    widget.enableAccountRecovery ? '' : 'Password is wrong.',
              ),
              const SizedBox(
                height: 8,
              ),
              !widget.enableAccountRecovery
                  ? Align(
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
                    )
                  : const SizedBox(),
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
                        _authenticate();
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
                    : Text(
                        widget.enableAccountRecovery ? 'Sign Up' : 'Sign In',
                        style: const TextStyle(
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
                  Text(
                    widget.question,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onTap(widget.enableAccountRecovery ? 1 : 0);
                    },
                    child: Text(
                      widget.action,
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
