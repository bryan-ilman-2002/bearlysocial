import 'dart:convert';

import 'package:bearlysocial/constants.dart';
import 'package:bearlysocial/generic/enums/api.dart';
import 'package:bearlysocial/generic/enums/db_key.dart';
import 'package:bearlysocial/generic/functions/generate_hash.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:bearlysocial/generic/functions/make_request.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/buttons/splash_btn.dart';
import 'package:bearlysocial/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/acc_recovery/account_recovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashlib/hashlib.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';

class PreAuthenticationPage extends ConsumerStatefulWidget {
  final Function(int) onTap;
  final bool accountCreation;
  final API url;
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

  String? _usernameError = null;
  String? _passwordError = null;
  String? _passwordAffirmationError = null;

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordAffirmationFocusNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAffirmationController =
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
    _passwordAffirmationFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordAffirmationFocusNode.dispose();
    super.dispose();
  }

  void _authenticate() async {
    setState(() {
      _blockInput = true;

      _usernameIsValid = _usernameController.text.isNotEmpty;
      _passwordIsValid = _passwordController.text.isNotEmpty;
    });

    if (_usernameIsValid && _passwordIsValid) {
      String id = hash16(_usernameController.text);
      String token = hash32(_passwordController.text);

      final Response httpResponse = await makeRequest(widget.url, {
        'id': id,
        'token': token,
      });

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSize.medium,
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
                    lightShadow,
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
                errorText: _usernameError,
              ),
              const SizedBox(
                height: WhiteSpaceSize.medium,
              ),
              UnderlinedTextField(
                label: 'Password',
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                errorText: _passwordError,
              ),
              widget.accountCreation
                  ? const SizedBox(
                      height: WhiteSpaceSize.medium,
                    )
                  : const SizedBox(),
              widget.accountCreation
                  ? UnderlinedTextField(
                      label: 'Password Reaffirmation',
                      obscureText: true,
                      controller: _passwordAffirmationController,
                      focusNode: _passwordAffirmationFocusNode,
                      errorText: _passwordAffirmationError,
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
                callbackFunction: _blockInput ? null : _authenticate,
                shadow: moderateShadow,
                child: _blockInput
                    ? SizedBox(
                        width: SideSize.verySmall,
                        height: SideSize.verySmall,
                        child: CircularProgressIndicator(
                          strokeWidth: ThicknessSize.large,
                          color: Theme.of(context).backgroundColor,
                        ),
                      )
                    : Text(
                        widget.accountCreation ? 'Sign Up' : 'Sign In',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).backgroundColor,
                                ),
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
