import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/widgets/buttons/setting_button.dart';
import 'package:bearlysocial/generic/widgets/lines/horizontal_thin_line.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final ScrollController controller;

  const SettingsPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: controller,
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
                Text(
                  'Mark Zuckerberg',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: heavyGray,
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
            const SettingButton(
              icon: Icons.person,
              label: 'Personal Information',
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
              child: Text(
                'Log Out',
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
