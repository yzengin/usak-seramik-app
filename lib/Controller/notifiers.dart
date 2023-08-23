import 'package:flutter/material.dart';
import '../Model/fake/product.dart';
import '../Rest/Entity/User/user_entity.dart';
import '/model/data.dart';

ValueNotifier<bool> exceptedAction = ValueNotifier<bool>(false);
ValueNotifier<DualData> onRouteNotifier = ValueNotifier<DualData>(DualData("", ""));
ValueNotifier<String?> serverAppBasePathNotifier = ValueNotifier<String?>(null);
ValueNotifier<UserEntity?> logedUserNotifier = ValueNotifier<UserEntity?>(UserEntity(name: ''));
ValueNotifier<String?> bearerSessionTokenNotifier = ValueNotifier<String?>(null);
ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
ValueNotifier<Locale?> localeNotifier = ValueNotifier<Locale?>(null);
ValueNotifier<List<Product>> likedProduct = ValueNotifier<List<Product>>([]);


