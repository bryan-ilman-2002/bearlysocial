import 'dart:convert';

import 'package:bearlysocial/api_call/enums/endpoint.dart';
import 'package:bearlysocial/api_call/make_request.dart';
import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/constants.dart';
import 'package:bearlysocial/database/db_key.dart';
import 'package:bearlysocial/database/db_operations.dart';
import 'package:bearlysocial/components/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/views/pre_auth/sign_in/sheets/account_recovery.dart';
import 'package:bearlysocial/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class PreAuthenticationPage extends ConsumerStatefulWidget {
  final Function(int) onTap;
  final bool accountCreation;
  final Endpoint url;
  final String exclamation;
  final String question;
  final String action;

  const PreAuthenticationPage({
    super.key,
    required this.onTap,
    required this.accountCreation,
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
  bool _blockInput = false;

  String? _usernameErrorText;
  String? _passwordErrorText;
  String? _passwordConfirmationErrorText;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmationFocusNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
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
    _passwordConfirmationFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    super.dispose();
  }

  void _getAccess() async {
    _validateInput();

    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (widget.accountCreation &&
          _passwordController.text != _passwordConfirmationController.text) {
        _showError(
          message: 'Passwords don\'t match.',
          field: 'passwordConfirmation',
        );
      } else {
        String hashedUsername = DatabaseOperations.getHash(
          input: _usernameController.text,
        );
        String hashedPassword = DatabaseOperations.getHash(
          input: _passwordController.text,
        );

        final Response httpResponse = await makeRequest(
          endpoint: widget.url,
          body: {
            'id': hashedUsername,
            'secret': hashedPassword,
          },
        );

        if (httpResponse.statusCode == 200) {
          _storeAccessNumber(
            id: hashedUsername,
            responseBody: httpResponse.body,
          );

          ref.watch(enterApp)();
        } else {
          widget.accountCreation
              ? _showError(
                  message: 'Username is already taken.',
                  field: 'username',
                )
              : _showError(
                  message: 'Password is wrong.',
                  field: 'password',
                );
        }
      }
    } else {
      setState(() {
        _blockInput = false;
      });
    }
  }

  void _validateInput() {
    setState(() {
      _blockInput = true;

      _usernameErrorText =
          _usernameController.text.isEmpty ? 'Username cannot be empty!' : null;
      _passwordErrorText =
          _passwordController.text.isEmpty ? 'Password cannot be empty!' : null;
    });
  }

  void _showError({
    required String message,
    required String field,
  }) {
    setState(() {
      switch (field) {
        case 'username':
          _usernameErrorText = message;
          break;
        case 'password':
          _passwordErrorText = message;
          break;
        case 'passwordConfirmation':
          _passwordConfirmationErrorText = message;
          break;
      }
      _blockInput = false;
    });
  }

  void _storeAccessNumber({
    required String id,
    required String responseBody,
  }) async {
    await DatabaseOperations.insertTransactions(
      pairs: {
        DatabaseKey.id.string: id,
        DatabaseKey.token.string: jsonDecode(responseBody)['token'],
      },
    );

    setState(() {
      _usernameErrorText = null;
      _passwordErrorText = null;
      if (widget.accountCreation) _passwordConfirmationErrorText = null;
      _blockInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSize.large,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SideSize.medium,
                height: SideSize.medium,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bearlysocial.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    Shadow.medium,
                  ],
                ),
              ),
              const SizedBox(
                height: WhiteSpaceSize.small,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 75,
                    child: Text(
                      widget.exclamation,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  const Expanded(
                    flex: 25,
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: WhiteSpaceSize.veryLarge,
              ),
              UnderlinedTextField(
                label: 'Username',
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                errorText: _usernameErrorText,
              ),
              const SizedBox(
                height: WhiteSpaceSize.medium,
              ),
              UnderlinedTextField(
                label: 'Password',
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                errorText: _passwordErrorText,
              ),
              widget.accountCreation
                  ? const SizedBox(
                      height: WhiteSpaceSize.medium,
                    )
                  : const SizedBox(),
              widget.accountCreation
                  ? UnderlinedTextField(
                      label: 'Password Confirmation',
                      obscureText: true,
                      controller: _passwordConfirmationController,
                      focusNode: _passwordConfirmationFocusNode,
                      errorText: _passwordConfirmationErrorText,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: WhiteSpaceSize.verySmall,
              ),
              widget.accountCreation
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return const AccountRecovery();
                            },
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: WhiteSpaceSize.large,
              ),
              SplashButton(
                width: double.infinity,
                verticalPadding: PaddingSize.small,
                borderRadius: BorderRadius.circular(
                  CurvatureSize.large,
                ),
                callbackFunction: _blockInput ? null : _getAccess,
                shadow: Shadow.medium,
                child: _blockInput
                    ? SizedBox(
                        width: SideSize.verySmall,
                        height: SideSize.verySmall,
                        child: CircularProgressIndicator(
                          strokeWidth: ThicknessSize.large,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      )
                    : Text(
                        widget.accountCreation ? 'Sign Up' : 'Sign In',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
              ),
              const SizedBox(
                height: WhiteSpaceSize.verySmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.question,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    width: WhiteSpaceSize.verySmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onTap(widget.accountCreation ? 1 : 0);
                    },
                    child: Text(
                      widget.action,
                      style: Theme.of(context).textTheme.displaySmall,
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
