import 'dart:convert';

import 'package:bearlysocial/generic/enums/api.dart';
import 'package:http/http.dart' as http;

Future<http.Response> makeRequest(API api, Map body) async {
  var url = Uri.parse(api.string);
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  return response;
}
