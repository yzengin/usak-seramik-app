// ignore_for_file: depend_on_referenced_packages

/*
 *      DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *      Copyright (C) 2021 Terra Yazılım
 *
 *      Licensed under the Apache License, Version 2.0 (the "License");
 *      you may not use this file except in compliance with the License.
 *      You may obtain a copy of the License at
 *
 *          http://www.apache.org/licenses/LICENSE-2.0
 *
 *      Unless required by applicable law or agreed to in writing, software
 *      distributed under the License is distributed on an "AS IS" BASIS,
 *      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *      See the License for the specific language governing permissions and
 *      limitations under the License.
 */

import 'dart:async';
import 'package:http/http.dart' as http;

import '../Response/base_response.dart';
import '../Response/find_response.dart';

Future<BaseResponse> deleteRequest (String url, {String? bearerToken}) async {

  Map<String,String> headers = {};
  headers["Content-Type"] = "application/json ; charset=utf-8";
  if(bearerToken != null){
    headers["token"] = "$bearerToken";
  }

  return http.delete(Uri.parse(url),
      headers:headers
  ).then((http.Response response) {
    return FindResponse.control(response);
  });
}