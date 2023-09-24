// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import '../../Controller/preferences.dart';
import '/Rest/Entity/Auth/login_entity.dart';

import '../../Controller/notifiers.dart';
import '../../View/widget/dialog/dialog.dart';
import '../Entity/Auth/register_entity.dart';
import '../Entity/User/user_entity.dart';
import '../Model/Response/base_response.dart';
import '../Model/Response/ok_response.dart';
import '../Service/Auth/authentication_service.dart';

class AppAuthHandler {
  static AppAuthHandler operations() {
    return AppAuthHandler();
  }

  Future<int> registerHandler({required RegisterEntity? registerEntity}) async {
    int status = 0;
    if (registerEntity != null) {
      exceptedAction.value = true;
      try {
        BaseResponse response = await AuthenticationService.operations().register(registerEntity: registerEntity);
        status = response.statusCode;
        if (response is OkResponse) {
          if (response.body != null) {
            // UserData.fromJson(response.body).data!;
          } else {
            status = 404;
          }
        } else {}
      } catch (e) {
        debugPrint('catch on registerHandler() $e');
      }
    }
    exceptedAction.value = false;
    return status;
  }

  Future<int> loginHandler(GlobalKey<FormState> formKey, {required String email, required String password}) async {
    int status = 0;
    if (email.isNotEmpty && password.isNotEmpty) {
      logedUserNotifier.value = UserEntity();
      exceptedAction.value = true;
      LoginEntity loginEntity = LoginEntity(email: email, password: password);
      try {
        BaseResponse response = await AuthenticationService.operations().login(loginEntity: loginEntity);
        status = response.statusCode;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        if (response is OkResponse) {
          if (response.body != null) {
            logedUserNotifier.value = UserData.fromJson(response.body).data!;
            sharedPreferences.setString("userTokenEntity", json.encode(logedUserNotifier.value!.toJson()));
            await _rememberMeController(email, password);
          } else {}
        } else {}
      } catch (e) {
        debugPrint('catch on loginHandler() > $e');
      }
    }
    exceptedAction.value = false;
    return status;
  }

  Future<bool> logoutHandler(BuildContext context) async {
    appDialog(context, message: context.translete('logoutText')).then((value) {
      if (value) {
        SharedPreferences.getInstance().then((prefs) {
          if (prefs.containsKey(AppPreferences.identity) || prefs.containsKey(AppPreferences.password)) {
            prefs.remove(AppPreferences.identity);
            prefs.remove(AppPreferences.password);
          }
          prefs.remove(AppPreferences.userTokenEntity).then((value) async {
            if (value) {
              // notificationFCMCloseSubscribe();
              logedUserNotifier.value = UserEntity();
            }
          });
        });
      }
    });
    return true;
  }

  Future<void> _rememberMeController(String identity, String password) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (rememberMeNotifier.value) {
      if (!(instance.containsKey(AppPreferences.identity) && instance.containsKey(AppPreferences.password))) {
        instance.setString(AppPreferences.identity, identity);
        instance.setString(AppPreferences.password, password);
      }
    } else {
      if (instance.containsKey(AppPreferences.identity) && instance.containsKey(AppPreferences.password)) {
        instance.remove(AppPreferences.identity);
        instance.remove(AppPreferences.password);
      }
    }
  }

  Future<bool> rememberMeGetIdentity() async {
    bool check = false;
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (shared.containsKey(AppPreferences.identity) && shared.containsKey(AppPreferences.password)) {
      await loginHandler(GlobalKey(), email: shared.getString(AppPreferences.identity)!, password: shared.getString(AppPreferences.password)!).then((value) {
        if (value == 200) {
          check = true;
          return check;
        }
      });
    }
    return check;
  }
}
