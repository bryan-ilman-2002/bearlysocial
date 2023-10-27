import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

class ProfilePictureStateNotifier extends StateNotifier<img.Image?> {
  ProfilePictureStateNotifier() : super(null);

  void setProfilePicture({required img.Image? profilePicture}) {
    state = profilePicture;
  }

  Widget displayProfilePicture() {
    if (state != null) {
      return ClipOval(
        child: Image.memory(Uint8List.fromList(img.encodePng(state!))),
      );
    } else {
      return const Icon(
        Icons.no_photography,
      );
    }
  }
}

final profilePictureStateNotifierProvider =
    StateNotifierProvider<ProfilePictureStateNotifier, img.Image?>(
  (ref) => ProfilePictureStateNotifier(),
);

final profilePicture = Provider((ref) {
  return ref.watch(profilePictureStateNotifierProvider);
});

final setProfilePicture = Provider((ref) {
  return ref
      .read(profilePictureStateNotifierProvider.notifier)
      .setProfilePicture;
});

final displayProfilePicture = Provider((ref) {
  return ref
      .read(profilePictureStateNotifierProvider.notifier)
      .displayProfilePicture;
});
