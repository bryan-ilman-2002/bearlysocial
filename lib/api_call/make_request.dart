import 'dart:convert';

import 'package:bearlysocial/api_call/enums/endpoint.dart';
import 'package:http/http.dart' as http;

Future<http.Response> makeRequest({
  required Endpoint endpoint,
  required Map body,
}) async {
  var url = Uri.parse(endpoint.string);
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  return response;
}
