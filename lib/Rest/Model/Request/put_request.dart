// ignore_for_file: unnecessary_string_interpolations, depend_on_referenced_packages, prefer_collection_literals, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Response/base_response.dart';
import '../Response/find_response.dart';

Future<BaseResponse> putRequest(String url, {dynamic entityData, String? bearerToken}) async {
  Map<String, String> headers = Map();
  headers["Content-Type"] = "application/json";
  if (bearerToken != null) {
    headers["token"] = "$bearerToken";
  }
  if (entityData != null) {
    Map<String, dynamic> _json = entityData.toJson();
    String encoded = json.encode(_json);
    debugPrint('put_request send > $encoded');
    return http.put(Uri.parse(url), headers: headers, body: encoded).then((http.Response response) {
      return FindResponse.control(response);
    });
  } else {
    return http
        .put(
      Uri.parse(url),
      headers: headers,
    )
        .then((http.Response response) {
      return FindResponse.control(response);
    });
  }
}
