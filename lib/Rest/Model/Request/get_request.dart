// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:http/http.dart' as http;

import '../Response/base_response.dart';
import '../Response/find_response.dart';

Future<BaseResponse> getRequest(String url, {String? bearerToken}) async {
  Map<String, String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  if (bearerToken != null) {
    headers["token"] = "$bearerToken";
  }

  return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
    return FindResponse.control(response);
  });
}

Future<BaseResponse> telegramGetRequest(String url, {String? chatId, String? message}) async {
  final Map<String, String> queryParams = {
    'chat_id': chatId ?? "",
    'text': message ?? "",
  };

  final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

  return http
      .get(
    uri,
  )
      .then((http.Response response) {
    return FindResponse.control(response);
  });
}
