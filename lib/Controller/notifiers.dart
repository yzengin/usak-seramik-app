import 'package:flutter/material.dart';
import '../Rest/Entity/User/user_entity.dart';
import '/model/data.dart';

ValueNotifier<bool> exceptedAction = ValueNotifier<bool>(false);
ValueNotifier<DualData> onRouteNotifier = ValueNotifier<DualData>(DualData("", ""));
ValueNotifier<String?> serverAppBasePathNotifier = ValueNotifier<String?>(null);
ValueNotifier<UserEntity?> logedUserNotifier = ValueNotifier<UserEntity?>(UserEntity(name: 'Kaan Kural'));
ValueNotifier<String?> bearerSessionTokenNotifier = ValueNotifier<String?>(null);
ValueNotifier<bool> rememberMeNotifier = ValueNotifier<bool>(false);
ValueNotifier<Locale?> localeNotifier = ValueNotifier<Locale?>(null);

