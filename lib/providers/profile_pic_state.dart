import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

class ProfilePictureStateNotifier extends StateNotifier<img.Image?> {
  ProfilePictureStateNotifier() : super(null);

  void setProfilePicture({
    required img.Image? profilePicture,
  }) {
    state = profilePicture;
  }

  Container displayProfilePicture({
    required BuildContext context,
    required bool enlarged,
  }) =>
      Container(
        width: SideSize.large,
        height: SideSize.large,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: state == null
              ? Border.all(
                  color: Theme.of(context).dividerColor,
                )
              : null,
        ),
        child: Center(
          child: state == null
              ? const Icon(
                  Icons.no_photography_outlined,
                )
              : ClipOval(
                  child:
                      Image.memory(Uint8List.fromList(img.encodePng(state!)))),
        ),
      );
}

final profilePictureStateNotifierProvider =
    StateNotifierProvider<ProfilePictureStateNotifier, img.Image?>(
  (ref) => ProfilePictureStateNotifier(),
);

final profilePic = Provider((ref) {
  return ref.watch(profilePictureStateNotifierProvider);
});

final setProfilePic = Provider((ref) {
  return ref
      .read(profilePictureStateNotifierProvider.notifier)
      .setProfilePicture;
});

final displayProfilePic = Provider((ref) {
  return ref
      .read(profilePictureStateNotifierProvider.notifier)
      .displayProfilePicture;
});
