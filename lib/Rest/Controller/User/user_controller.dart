import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/Controller/notifiers.dart';
import '/Controller/preferences.dart';
import '/Rest/Entity/User/user_entity.dart';

class UserController with ChangeNotifier {
  UserEntity _userEntity = UserEntity();
  UserEntity get userEntity => _userEntity;
  set userEntity(UserEntity data) => _userEntity = data;

  Future<int> getUserByIdController(int id) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      await SharedPreferences.getInstance().then((prefs){
        if (prefs.containsKey(AppPreferences.userTokenEntity)) {
          
        }
      });
    } catch (e) {
      debugPrint('catch on getUserByIdController() > $e');
    }
    exceptedAction.value = false;
    return status;
  }
}
