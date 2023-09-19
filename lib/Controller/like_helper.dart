import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import 'package:usak_seramik_app/Model/fake/product.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';

class AppLikeHelper {
  static Future<bool> itWasLiked(ProductEntity data) async {
    bool like = false;
    debugPrint('like GELEN DATA: ${data.id}');
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getStringList(AppPreferences.favorites) == null) {
        await preferences.setStringList(AppPreferences.favorites, []).then((value) {});
      }
      List<String>? likedList = preferences.getStringList(AppPreferences.favorites);
      likedList!.forEach((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        if (product.id == data.id) {
          like = true;
        } else {
          like = false;
        }
      });
      preferences.setStringList(AppPreferences.favorites, likedList).then((value) {});
    } on Exception catch (e) {
      debugPrint('AppLikeHelper.itWasLiked() $e');
    }

    return like;
  }

  static Future<bool> likeToggle(dynamic data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getStringList(AppPreferences.favorites) == null) {
        await preferences.setStringList(AppPreferences.favorites, []).then((value) {});
      }
      List<String>? likedList = preferences.getStringList(AppPreferences.favorites);
      List<ProductEntity> midProductList = [];
      likedList!.forEach((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        midProductList.add(product);
      });

      midProductList.forEach((element) {
        if (element.id != data.id) {
          midProductList.add(data);
        } else {
          midProductList.remove(data);
        }
      });

      if (midProductList.isEmpty) {
        midProductList.add(data);
      }

      likedList.clear();
      midProductList.forEach((element) {
        likedList.add(json.encode(element.toJson()));
      });

      preferences.setStringList(AppPreferences.favorites, likedList).then((value) {});
    } on Exception catch (e) {
      debugPrint('AppLikeHelper.likePreferences() $e');
    }
    return await itWasLiked(data);
  }
}
