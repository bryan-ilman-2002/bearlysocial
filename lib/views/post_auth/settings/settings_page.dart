import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/providers/auth_state.dart';
import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/components/buttons/setting_btn.dart';
import 'package:bearlysocial/providers/profile_pic_state.dart';
import 'package:bearlysocial/views/post_auth/settings/personal_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final ScrollController controller;

  const SettingsPage({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.controller,
        // physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(
          PaddingSize.medium,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ref.read(displayProfilePic)(
              context: context,
              enlarged: true,
            ),
            const SizedBox(
              height: WhiteSpaceSize.medium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mark Zuckerberg',
                  maxLines: 4,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(
              height: WhiteSpaceSize.medium / 2,
            ),
            SettingButton(
              icon: Icons.person_outlined,
              label: 'Personal Information',
              callbackFunction: () {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return const PersonalInformation();
                  },
                );
              },
            ),
            SettingButton(
              icon: Icons.translate,
              label: 'Translation',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.cloud_download_outlined,
              label: 'Request Personal Data',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.delete_outlined,
              label: 'Delete Account',
              callbackFunction: () {},
              splashColor: AppColor.lightRed,
              contentColor: AppColor.heavyRed,
            ),
            const SizedBox(
              height: WhiteSpaceSize.veryLarge,
            ),
            SettingButton(
              icon: Icons.help_outline_outlined,
              label: 'Help Center',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.menu_book,
              label: 'Terms of Service',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.menu_book,
              label: 'Privacy Policy',
              callbackFunction: () {},
            ),
            const SizedBox(
              height: WhiteSpaceSize.medium,
            ),
            SplashButton(
              verticalPadding: PaddingSize.small,
              callbackFunction: ref.watch(exitApp),
              buttonColor: Colors.transparent,
              borderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(
                CurvatureSize.large,
              ),
              splashColor: AppColor.lightRed,
              child: Text(
                'Sign Out',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColor.heavyRed,
                    ),
              ),
            ),
            const SizedBox(
              height: WhiteSpaceSize.verySmall,
            ),
          ],
        ),
      ),
    );
  }
}