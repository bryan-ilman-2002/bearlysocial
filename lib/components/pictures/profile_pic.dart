import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/providers/profile_pic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: SideSize.large,
      height: SideSize.large,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: ref.watch(profilePic) == null
            ? Border.all(
                color: Theme.of(context).dividerColor,
              )
            : null,
      ),
      child: Center(
        child: ref.watch(profilePic) == null
            ? const Icon(
                Icons.no_photography_outlined,
              )
            : ClipOval(
                child: Image.memory(
                  Uint8List.fromList(
                    img.encodePng(ref.watch(profilePic)!),
                  ),
                ),
              ),
      ),
    );
  }
}
