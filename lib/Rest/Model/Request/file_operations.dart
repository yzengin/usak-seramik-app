// ignore_for_file: depend_on_referenced_packages, library_prefixes, unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

import '../../../Controller/notifiers.dart';

class FileOperations {
  static Future<bool> uploadFile(Uint8List fileUint8List, fileName, String imagePath) async {
    try {
      if (fileUint8List == null) return false;

      Img.Image image = Img.decodeImage(fileUint8List)!;

      final directory = await getApplicationDocumentsDirectory();
      File file2 = File('${directory.path}/app/picture.jpg');
      file2.createSync(recursive: true);
      file2.writeAsBytesSync(encodeJpg(image));
      String base64Image = base64Encode(file2.readAsBytesSync());
      String apiUserBaseUrlEndpoint = "${serverAppBasePathNotifier.value}/$imagePath";
      debugPrint('--@@@@@@@@@- ${apiUserBaseUrlEndpoint}');
      return http.post(Uri.parse(apiUserBaseUrlEndpoint), body: {
        "image": base64Image,
        "filename": fileName,
      }).then((res) {
        return res.statusCode == 200;
      }).catchError((err) {
        return false;
      });
    } catch (e) {
      return false;
    }
  }
}
