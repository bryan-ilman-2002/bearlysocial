import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

class ProfileStateNotifier extends StateNotifier<Profile> {
  ProfileStateNotifier() : super(Profile());
}

final profileStateNotifierProvider =
    StateNotifierProvider<ProfileStateNotifier, Profile>(
  (ref) => ProfileStateNotifier(),
);

final profile = Provider((ref) {
  return ref.watch(profileStateNotifierProvider);
});

class Profile {
  img.Image? picture;
  String? firstName;
  String? lastName;

  Profile();

  void setPicture({required img.Image? profilePicture}) {
    picture = profilePicture;
  }
}
