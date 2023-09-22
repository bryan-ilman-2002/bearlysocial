String _domain = 'https://zd0d10d8p2.execute-api.us-east-1.amazonaws.com/';
String _routePrefix = '';

enum API {
  signUp,
  signIn,
}

extension GetString on API {
  String get string {
    switch (this) {
      case API.signUp:
        return '$_domain$_routePrefix' 'sign-up';
      case API.signIn:
        return '$_domain$_routePrefix' 'sign-in';
      default:
        return '';
    }
  }
}
