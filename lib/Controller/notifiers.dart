import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import '../Rest/Entity/Product/product_detail_entity.dart';
import '../Rest/Entity/User/user_entity.dart';
import '/model/data.dart';

ValueNotifier<bool> exceptedAction = ValueNotifier<bool>(false);
ValueNotifier<DualData> onRouteNotifier = ValueNotifier<DualData>(DualData("", ""));
ValueNotifier<String?> serverAppBasePathNotifier = ValueNotifier<String?>(null);
ValueNotifier<UserEntity?> logedUserNotifier = ValueNotifier<UserEntity?>(UserEntity(name: ''));
ValueNotifier<String> bearerSessionTokenNotifier = ValueNotifier<String>('UsakSeramik2023MobileApplication');
ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
ValueNotifier<Locale?> localeNotifier = ValueNotifier<Locale?>(null);
ValueNotifier<List<ProductDetailEntity>> likedProduct = ValueNotifier<List<ProductDetailEntity>>([]);


