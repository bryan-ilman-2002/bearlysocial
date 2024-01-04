import 'package:bearlysocial/constants.dart';

enum Endpoint {
  signUp,
  signIn,
  validateToken,
}

final Map<Endpoint, String> endpointToString = {
  Endpoint.signUp: 'sign-up',
  Endpoint.signIn: 'sign-in',
  Endpoint.validateToken: 'validate-token',
};

extension GetString on Endpoint {
  String get string {
    return '${URL.domain}${URL.apiSubFolder}${endpointToString[this]}';
  }
}
