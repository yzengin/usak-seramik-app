// ignore_for_file: depend_on_referenced_packages, prefer_collection_literals, unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Response/base_response.dart';
import '../Response/find_response.dart';

Future<BaseResponse> patchRequest(String url, {dynamic entityData, String? bearerToken}) async {
  Map<String, String> headers = new Map();
  headers["Content-Type"] = "application/json";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }

  Map<String, dynamic> _json = entityData.toJson();
  String encoded = json.encode(_json);
  return http.patch(Uri.parse(url), headers: headers, body: encoded).then((http.Response response) {
    return FindResponse.control(response);
  });
}
