import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:bearlysocial/generic/functions/providers/auth.dart';
import 'package:bearlysocial/generic/functions/show_modal_bottom_sheet.dart';
import 'package:bearlysocial/buttons/splash_btn.dart';
import 'package:bearlysocial/buttons/setting_button.dart';
import 'package:bearlysocial/generic/widgets/lines/horizontal_thin_line.dart';
import 'package:bearlysocial/generic/widgets/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:bearlysocial/specific/widgets/modals/personal_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final ScrollController controller;

  const SettingsPage({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<SettingsPage> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.controller,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 32,
              ),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: moderateGray,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.no_photography,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Mark Zuckerberg',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: heavyGray,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            // TODO
            const SizedBox(
              height: 16,
            ),
            SettingButton(
              icon: Icons.person,
              label: 'Personal Information',
              callbackFunction: () {
                showFullHeightModalBottomSheet(
                  context: context,
                  body: app_bottom_sheet.BottomSheet(
                    title: 'Personal Information',
                    content: SizedBox(),
                    // content: const PersonalInformation(),
                    closure: [
                      SplashButton(
                        horizontalPadding: 48,
                        verticalPadding: 16,
                        buttonColor: Colors.white,
                        // uniformBorderRadius: 16,
                        borderColor: Colors.transparent,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: heavyGray,
                          ),
                        ),
                      ),
                      SplashButton(
                        horizontalPadding: 48,
                        verticalPadding: 16,
                        buttonColor: heavyGray,
                        // uniformBorderRadius: 16,
                        borderColor: Colors.transparent,
                        // buttonShadow: moderateShadow,
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SettingButton(
              icon: Icons.translate,
              label: 'Translation',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SettingButton(
              icon: Icons.notifications,
              label: 'Notifications',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SettingButton(
              icon: Icons.cloud_download,
              label: 'Request Personal Data',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            SettingButton(
              icon: Icons.delete,
              label: 'Delete Account',
              iconColor: moderateRed,
              labelColor: moderateRed,
              splashColor: lightRed,
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SizedBox(height: 80),
            const SettingButton(
              icon: Icons.help,
              label: 'Help Center',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SettingButton(
              icon: Icons.menu_book,
              label: 'Terms of Service',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SettingButton(
              icon: Icons.menu_book,
              label: 'Privacy Policy',
            ),
            const HorizontalThinLine(
              height: 0.12,
            ),
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
              onTap: ref.watch(exitApp),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: moderateRed,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
