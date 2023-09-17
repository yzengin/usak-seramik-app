// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations, no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Response/base_response.dart';
import '../Response/find_response.dart';

Future<BaseResponse> postRequest(String url, {dynamic entityData, String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }

  if (entityData != null) {
    Map<String, dynamic> _json = entityData.toJson();
    String encoded = json.encode(_json);
    // debugPrint(encoded);

    return http.post(Uri.parse(url), headers: headers, body: encoded).then((http.Response response) {
      debugPrint(response.statusCode.toString());
      return FindResponse.control(response);
    });
  } else {
    return http
        .post(
      Uri.parse(url),
      headers: headers,
    )
        .then((http.Response response) {
      debugPrint(response.statusCode.toString());
      return FindResponse.control(response);
    });
  }
}

Future<BaseResponse> multiPartPostDataRequest(String url, {dynamic entityData, String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json";
  if (bearerToken != null) {
    headers["Authorization"] = "Bearer $bearerToken";
  }
  if (entityData != null) {
    var request = http.MultipartRequest("POST", Uri.parse("$url"));
    request.headers.addAll(headers);
    request = jsonToFormData(request, entityData.toJson());
    return http.Response.fromStream(await request.send()).then((http.Response response) {
      debugPrint(response.statusCode.toString());
      return FindResponse.control(response);
    });
  } else {
    var request = http.MultipartRequest("POST", Uri.parse("$url"));
    request.headers.addAll(headers);
    return http.Response.fromStream(await request.send()).then((http.Response response) {
      debugPrint(response.statusCode.toString());
      return FindResponse.control(response);
    });
  }
}

jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}
