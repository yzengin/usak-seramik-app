import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';

class AppLikeHelper {
  static Future<bool> itWasLiked(ProductEntity data) async {
    bool like = false;
    debugPrint('itWasLiked GELEN DATA: ${data.id} -- ${data.name}');
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getStringList(AppPreferences.favorites) == null) {
        await preferences.setStringList(AppPreferences.favorites, []).then((value) {});
      }
      List<String>? likedList = preferences.getStringList(AppPreferences.favorites);
      print('LİKEE LİSTT ---> ${likedList!.length}');
      likedList.forEach((element) {
        int index =0;
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        print('ELEMENT PRODUCT ${index++}-- >> ${product.name} -- ${product.id}');
        if (product.id == data.id) {
          like = true;
        }else{
          print('gelen data false >>> ${data.id} --${data.name}');
        }
      });
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
      List<ProductEntity> newProductList = [];
      print('------1111');
      likedList!.forEach((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        midProductList.add(product);
        print('mid length---${midProductList.length}');
      });

    print('------22222');
    midProductList.forEach((element) {
        print('GELEN ELEMENT TOOGLE -->> -${element.name}');
        if (element.id != data.id) {
          print('@@@@00000000 -->> -${element.id}');
          newProductList.add(data);
        } else {
          print('-------@@@@1111');
          newProductList.remove(data);
          print('-------@@@@22222');
        }
      });
      print('------33333');
      if (newProductList.isEmpty) {
        newProductList.add(data);
      }

      likedList.clear();
      newProductList.forEach((element) {
        likedList.add(json.encode(element.toJson()));
      });

      preferences.setStringList(AppPreferences.favorites, likedList).then((value) {});
    } on Exception catch (e) {
      debugPrint('AppLikeHelper.likePreferences() $e');
    }
    return await itWasLiked(data);
  }
}
