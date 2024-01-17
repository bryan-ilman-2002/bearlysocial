import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

class ProfilePictureStateNotifier extends StateNotifier<img.Image?> {
  ProfilePictureStateNotifier() : super(null);

  void setProfilePicture({
    required img.Image? profilePicture,
  }) {
    state = profilePicture;
  }
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
