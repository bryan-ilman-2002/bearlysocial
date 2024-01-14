import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/constants/social_media_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaLink extends StatelessWidget {
  final SocialMedia platform;
  final bool enableInput;

  const SocialMediaLink({
    super.key,
    required this.platform,
    this.enableInput = true,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? linkStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).focusColor,
            );

    return GestureDetector(
      onTap: () => enableInput
          ? null
          : launchUrl(
              Uri.parse(platform.domain),
              mode: LaunchMode.externalApplication,
            ),
      onLongPress: () => enableInput
          ? null
          : Clipboard.setData(
              ClipboardData(
                text: platform.domain,
              ),
            ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PaddingSize.verySmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'unverified',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(
              PaddingSize.verySmall,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              border: Border.all(
                color: Colors.transparent,
                width: ThicknessSize.medium,
              ),
              borderRadius: BorderRadius.circular(
                CurvatureSize.large,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svgs/${platform.icon}',
                  width: SideSize.small,
                  height: SideSize.small,
                  color: Theme.of(context).focusColor,
                ),
                const SizedBox(
                  width: WhiteSpaceSize.verySmall,
                ),
                enableInput
                    ? Expanded(
                        child: TextField(
                          style: linkStyle,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Type your username here.',
                            hintStyle: linkStyle,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Text(
                          platform.domain,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                      ),
                SvgPicture.asset(
                  'assets/svgs/warning_icon.svg',
                  width: SideSize.small,
                  height: SideSize.small,
                  color: Theme.of(context).focusColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
