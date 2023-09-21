import 'dart:convert';

import 'package:crypto/crypto.dart';

String hash16(String input) {
  var bytes = utf8.encode(input);
  var digest = sha256.convert(bytes);
  return digest.toString().substring(0, 16);
}

String hash32(String input) {
  var bytes = utf8.encode(input);
  var digest = sha256.convert(bytes);
  return digest.toString().substring(digest.toString().length - 32);
}
