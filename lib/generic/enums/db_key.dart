enum DatabaseKey {
  id,
  mainAccessNumber,
  profilePicture,
  firstName,
  lastName,
  interests,
  languages,
  instagramUsername,
  facebookUsername,
  linkedInUsername,
  email,
  completeProfile,
}

final Map<DatabaseKey, String> databaseKeyValues = {
  DatabaseKey.id: 'id',
  DatabaseKey.mainAccessNumber: 'mainAccessNumber',
  DatabaseKey.profilePicture: 'profilePicture',
  DatabaseKey.firstName: 'firstName',
  DatabaseKey.lastName: 'lastName',
  DatabaseKey.interests: 'interests',
  DatabaseKey.languages: 'languages',
  DatabaseKey.instagramUsername: 'instagramUsername',
  DatabaseKey.facebookUsername: 'facebookUsername',
  DatabaseKey.linkedInUsername: 'linkedInUsername',
  DatabaseKey.email: 'email',
  DatabaseKey.completeProfile: 'completeProfile',
};

extension GetString on DatabaseKey {
  String get string {
    return databaseKeyValues[this]!;
  }
}
