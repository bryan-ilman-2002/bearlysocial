enum API {
  signUp,
}

extension GetString on API {
  String get string {
    switch (this) {
      case API.signUp:
        return 'https://w2yw1clp47.execute-api.us-east-1.amazonaws.com/sign-up';
      default:
        return '';
    }
  }
}
