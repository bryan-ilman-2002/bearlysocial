enum DatabaseKey {
  id,
  token,
  firstName,
  lastName,
  languages,
  interests,
  instagramUsername,
  facebookUsername,
  linkedInUsername,
  email,
}

final Map<DatabaseKey, String> dbKeyToString = {
  DatabaseKey.id: 'id',
  DatabaseKey.token: 'token',
  DatabaseKey.firstName: 'firstName',
  DatabaseKey.lastName: 'lastName',
  DatabaseKey.languages: 'languages',
  DatabaseKey.interests: 'interests',
  DatabaseKey.instagramUsername: 'instagramUsername',
  DatabaseKey.facebookUsername: 'facebookUsername',
  DatabaseKey.linkedInUsername: 'linkedInUsername',
  DatabaseKey.email: 'email',
};

extension GetString on DatabaseKey {
  String get string {
    return dbKeyToString[this]!;
  }
}
