enum DatabaseKey {
  id,
  mainAccessNumber,
}

extension GetString on DatabaseKey {
  String get string {
    switch (this) {
      case DatabaseKey.id:
        return 'id';
      case DatabaseKey.mainAccessNumber:
        return 'mainAccessNumber';
      default:
        return '';
    }
  }
}
