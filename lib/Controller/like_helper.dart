import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';

class AppLikeHelper {
  static Future<bool> itWasLiked(ProductEntity data) async {
    bool like = false;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getStringList(AppPreferences.favorites) == null) {
        await preferences.setStringList(AppPreferences.favorites, []).then((value) {});
      }
      List<String>? likedList = preferences.getStringList(AppPreferences.favorites);
      likedList!.forEach((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        debugPrint('${product.name}');
        if (product.id == data.id) {
          like = true;
        }
      });
    } on Exception catch (e) {
      debugPrint('AppLikeHelper.itWasLiked() $e');
    }
    return like;
  }

  static Future<bool> likeToggle(ProductEntity data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? likedList = preferences.getStringList(AppPreferences.favorites) ?? [];

      bool isLiked = false;

      final existingProductIndex = likedList.indexWhere((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        return product.id == data.id;
      });

      if (existingProductIndex != -1) {
        likedList.removeAt(existingProductIndex);
      } else {
        likedList.add(json.encode(data.toJson()));
        isLiked = true;
      }

      await preferences.setStringList(AppPreferences.favorites, likedList);
      return isLiked;
    } catch (e) {
      debugPrint('AppLikeHelper.likePreferences() $e');
      return false;
    }
  }
}

class AppCartHelper {
  static Future<bool> itWasAddedCart(ProductEntity data) async {
    bool cart = false;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getStringList(AppPreferences.cart) == null) {
        await preferences.setStringList(AppPreferences.cart, []).then((value) {});
      }
      List<String>? cartList = preferences.getStringList(AppPreferences.cart);
      cartList!.forEach((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        debugPrint('${product.name}');
        if (product.id == data.id) {
          cart = true;
        }
      });
    } on Exception catch (e) {
      debugPrint('AppLikeHelper.itWasAddedCart() $e');
    }
    return cart;
  }

  static Future<bool> cartToggle(ProductEntity data, {bool remove = false}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? cartList = preferences.getStringList(AppPreferences.cart) ?? [];

      bool isAddedCart = false;

      final existingProductIndex = cartList.indexWhere((element) {
        ProductEntity product = ProductEntity.fromJson(json.decode(element));
        return product.id == data.id;
      });

      if (remove) {
        cartList.removeAt(existingProductIndex);
      } else {
        if (existingProductIndex != -1) {
          cartList.removeAt(existingProductIndex);
        } else {
          cartList.add(json.encode(data.toJson()));
          isAddedCart = true;
        }
      }

      await preferences.setStringList(AppPreferences.cart, cartList);
      return isAddedCart;
    } catch (e) {
      debugPrint('AppLikeHelper.cartPreferences() $e');
      return false;
    }
  }

  static Future<bool> cartClean() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? cartList = [];

      await preferences.setStringList(AppPreferences.cart, cartList);
      return true;
    } catch (e) {
      debugPrint('AppLikeHelper.cartPreferences() $e');
      return false;
    }
  }
}
