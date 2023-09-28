// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

import '../View/widget/dialog/dialog.dart';
import 'auth_error.dart';

bool developerMode() => false;
bool basketMode = true;

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

Future<void> firebaseDialogSwitch(FirebaseAuthException e, BuildContext context) async{
  AuthError authError = determineFirebaseError(e);
  switch (authError) {
    case AuthError.invalidEmail:
      appDialog(context, message: context.translete('invalidEmail'), dialogType: DialogType.failed);
      break;
    case AuthError.userDisabled:
      appDialog(context, message: context.translete('userDisabled'), dialogType: DialogType.failed);
      break;
    case AuthError.userNotFound:
      appDialog(context, message: context.translete('userNotFound'), dialogType: DialogType.failed);
      break;
    case AuthError.wrongPassword:
      appDialog(context, message: context.translete('wrongPassword'), dialogType: DialogType.failed);
      break;
    case AuthError.emailAlreadyInUse:
      appDialog(context, message: context.translete('emailAlreadyInUse'), dialogType: DialogType.failed);
      break;
    case AuthError.invalidCredential:
      appDialog(context, message: context.translete('invalidCredential'), dialogType: DialogType.failed);
      break;
    case AuthError.operationNotAllowed:
      appDialog(context, message: context.translete('operationNotAllowed'), dialogType: DialogType.failed);
      break;
    case AuthError.weakPassword:
      appDialog(context, message: context.translete('weakPassword'), dialogType: DialogType.failed);
      break;
    default:
      appDialog(context, message: context.translete('userNotFoundText'), dialogType: DialogType.failed);
  }
}
