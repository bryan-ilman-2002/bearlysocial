import 'package:bearlysocial/generic/enums/social_media.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/app_shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLink extends StatelessWidget {
  final SocialMedia platform;

  const SocialMediaLink({
    super.key,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(platform.domain),
          mode: LaunchMode.externalApplication),
      onLongPress: () =>
          Clipboard.setData(ClipboardData(text: platform.domain)),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Unverified',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightGray,
              border: Border.all(
                color: Colors.transparent,
                width: 1.6,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                heavyShadow,
              ],
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/${platform.icon}',
                  width: 24,
                  height: 24,
                  color: heavyGray,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    platform.domain,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: moderateBlue,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/svgs/warning_icon.svg',
                  width: 24,
                  height: 24,
                  color: heavyGray,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
