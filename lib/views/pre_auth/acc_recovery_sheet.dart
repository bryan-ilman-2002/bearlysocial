import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/components/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/base_designs/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:bearlysocial/constants/translation_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountRecovery extends StatefulWidget {
  // [AccountRecovery] is a [StatefulWidget] that handles the recovery of a user account.

  const AccountRecovery({super.key});

  @override
  State<AccountRecovery> createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();

  bool _submitted = false;
  String? _emailErrorText;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _checkEmail() {
    setState(() {
      final RegExp emailRegExp = RegExp(
          r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
      if (emailRegExp.hasMatch(_emailController.text)) {
        _submitted = true;
        _emailErrorText = null;
      } else {
        _emailErrorText = TranslationKey.invalidEmail.name.tr();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return app_bottom_sheet.BottomSheet(
      title: TranslationKey.accountRecoveryTitle.name.tr(),
      content: _submitted
          ? Column(
              children: [
                Icon(
                  Icons.check_rounded,
                  size: IconSize.large,
                  color: Theme.of(context).focusColor,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Text(
                  TranslationKey.checkEmail.name.tr(),
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              children: [
                UnderlinedTextField(
                  label: TranslationKey.emailLabel.name.tr(),
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  errorText: _emailErrorText,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Text(
                  TranslationKey.provideEmail.name.tr(),
                  maxLines: 128,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: WhiteSpaceSize.small,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SplashButton(
                    width: SideSize.large,
                    verticalPadding: PaddingSize.small,
                    borderRadius: BorderRadius.circular(
                      CurvatureSize.large,
                    ),
                    callbackFunction: _checkEmail,
                    shadow: Shadow.medium,
                    child: Text(
                      TranslationKey.submitButton.name.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
