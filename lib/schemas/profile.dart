import 'package:isar/isar.dart';

part 'profile.g.dart';

@collection
class Profile {
  late Id userId;

  List<int>? profilePicture;

  String? firstName;

  String? lastName;

  String? interests;

  String? languages;

  String? instagramUsername;

  String? facebookUsername;

  String? linkedInUsername;

  String? email;
}
