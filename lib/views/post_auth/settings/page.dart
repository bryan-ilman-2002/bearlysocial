import 'package:bearlysocial/constants.dart';
import 'package:bearlysocial/providers/auth.dart';
import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/components/buttons/setting_btn.dart';
import 'package:bearlysocial/base_designs/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:bearlysocial/views/post_auth/settings/personal_information.dart';
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
        // physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(
          PaddingSize.medium,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SideSize.large,
              height: SideSize.large,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).focusColor,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.no_photography,
                ),
              ),
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
              height: 16.0,
            ),
            SettingButton(
              icon: Icons.person,
              label: 'Personal Information',
              callbackFunction: () {},
              // callbackFunction: () {
              //   showFullHeightModalBottomSheet(
              //     context: context,
              //     body: app_bottom_sheet.BottomSheet(
              //       title: 'Personal Information',
              //       content: SizedBox(),
              //       // content: const PersonalInformation(),
              //       closure: [
              //         SplashButton(
              //           horizontalPadding: 48,
              //           verticalPadding: 16,
              //           buttonColor: Colors.white,
              //           // uniformBorderRadius: 16,
              //           borderColor: Colors.transparent,
              //           child: Text(
              //             'Reset',
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: heavyGray,
              //             ),
              //           ),
              //         ),
              //         SplashButton(
              //           horizontalPadding: 48,
              //           verticalPadding: 16,
              //           buttonColor: heavyGray,
              //           // uniformBorderRadius: 16,
              //           borderColor: Colors.transparent,
              //           // buttonShadow: moderateShadow,
              //           child: const Text(
              //             'Apply',
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // },
            ),
            SettingButton(
              icon: Icons.translate,
              label: 'Translation',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.notifications,
              label: 'Notifications',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.cloud_download,
              label: 'Request Personal Data',
              callbackFunction: () {},
            ),
            SettingButton(
              icon: Icons.delete,
              label: 'Delete Account',
              callbackFunction: () {},
              splashColor: AppColor.lightRed,
              contentColor: AppColor.heavyRed,
            ),
            const SizedBox(
              height: WhiteSpaceSize.veryLarge,
            ),
            SettingButton(
              icon: Icons.help,
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
