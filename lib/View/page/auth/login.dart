// ignore_for_file: library_private_types_in_public_api, unnecessary_new
import 'dart:convert';
import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Controller/theme.dart';
import 'package:usak_seramik_app/View/widget/utility/theme_changer.dart';
import '../../../Controller/auth_error.dart';
import '../../../Controller/controller.dart';
import '../../../Controller/extension.dart';
import '../../../Controller/localization.dart';
import '../../../Controller/notifiers.dart';
import '../../../Controller/preferences.dart';
import '../../../Model/languages.dart';
import '../../../Rest/Entity/User/user_entity.dart';
import '../../widget/dialog/dialog.dart';
import '../../widget/utility/copy_on_tap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.switchCallback}) : super(key: key);
  final VoidCallback switchCallback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _obscureTextLogin = true;

  @override
  void initState() {
    super.initState();
    _handleGoogleAppleSignOut();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Image.asset(AppImage.logotype, width: context.width * 0.6, color: context.theme.appBarTheme.backgroundColor!.getContrastColor()),
          toolbarHeight: kToolbarHeight * 3,
          centerTitle: true,
          bottom: PreferredSize(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CopyOnTap(
                      languageList().where((element) => element.locale.languageCode != localeNotifier.value!.languageCode).first.title,
                      callback: () => Provider.of<LocalizationController>(context, listen: false).set(localeNotifier.value!.languageCode == 'tr' ? languageList()[1].locale : languageList().first.locale),
                    ).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.background, fontSize: 14)).wrapPaddingRight(20),
                    ThemeChangerButton(),
                  ],
                ),
              ).wrapPaddingAll(20),
              preferredSize: Size.fromHeight(kToolbarHeight)),
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: context.translete('email'),
                  ),
                  textInputAction: TextInputAction.next,
                ).wrapPaddingTop(20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureTextLogin,
                  decoration: InputDecoration(
                    labelText: context.translete('password'),
                    suffixIcon: GestureDetector(
                      onTap: _toggleLogin,
                      child: Icon(
                        _obscureTextLogin
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: context.theme.colorScheme.background,
                      ),
                    ),
                  ),
                ).wrapPaddingTop(20),
                ElevatedButton(
                    onPressed: () {
                      if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                        loginFirebaseEmailAndPassword(_usernameController.text, _passwordController.text);
                      }else{
                        appDialog(context, message: context.translete("pleaseFillAllFields"), dialogType: DialogType.failed);
                      }
                    },
                    child: Text(context.translete('login'))).wrapPaddingTop(20),
                GestureDetector(
                    onTap: (){
                      logedUserNotifier.value = UserEntity();
                      logedUserNotifier.value!.email = "misafir";
                      logedUserNotifier.value!.password = "misafir";
                      Navigator.pushNamed(context, AppRoutes.mainpageview);
                    },
                    child: Text(context.translete('guestLoginText')).wrapPaddingTop(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Platform.isIOS ?
                    GestureDetector(
                      onTap: (){
                        signInWithApple();
                      },
                      child: AppleAuthButton(
                        style: AuthButtonStyle(buttonType: AuthButtonType.icon, iconColor: context.theme.iconTheme.color, buttonColor: Colors.transparent),
                        darkMode: Provider.of<ThemeController>(context, listen: true).isDark,
                      ),
                    ): SizedBox(),
                    GestureDetector(
                      onTap: (){
                        signInWithGoogle();
                      },
                      child: GoogleAuthButton(
                        style: AuthButtonStyle(buttonType: AuthButtonType.icon, iconColor: context.theme.iconTheme.color, buttonColor: Colors.transparent),
                        darkMode: !Provider.of<ThemeController>(context, listen: true).isDark,
                      ),
                    ),
                  ],
                ).wrapPaddingTop(20),
                Text(context.translete('notRegister')).wrapPaddingTop(40),
                ElevatedButton(
                  onPressed: () {
                    widget.switchCallback.call();
                  },
                  child: Text(context.translete('register'))).wrapPaddingTop(20),
              ],
            ).wrapPaddingHorizontal(20),
          ),
        ),
      ),
    );
  }


  Future<void> loginFirebaseEmailAndPassword(String emailAddress, String password) async{
    try {
        UserCredential? userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );

        if (userCredential!=null && userCredential.user != null) {

          UserEntity mobilUserEntity = new UserEntity();
          if(userCredential.user!.displayName!=null){
            mobilUserEntity.name = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(0, userCredential.user!.displayName!.lastIndexOf(" ")) : userCredential.user!.displayName;
            mobilUserEntity.lastName = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(userCredential.user!.displayName!.lastIndexOf(" ")) : "";
          }
          mobilUserEntity.email = userCredential.user!.email;
          mobilUserEntity.password = password;
          mobilUserEntity.id = userCredential.user!.uid;

          print('GELENN -- >>> ${mobilUserEntity.toJson()}');
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString(AppPreferences.userTokenEntity, json.encode(mobilUserEntity.toJson()));
          sharedPreferences.setString(AppPreferences.identity, emailAddress);
          sharedPreferences.setString(AppPreferences.password, password);

          logedUserNotifier.value = mobilUserEntity;
          Navigator.pushNamed(context, AppRoutes.mainpageview);
        }else{
          appDialog(context, message: context.translete('userNotFoundText'), dialogType: DialogType.failed);
        }

      } on FirebaseAuthException catch (e) {
        firebaseDialogSwitch(e, context);
    } catch (e) {
      print("ERRRORR --- ${e}");
      appDialog(context, message: context.translete('userNotFoundText'), dialogType: DialogType.failed);
    }
  }

  Future<void> _handleGoogleAppleSignOut() async{
    try{
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print('ERROR SIGN OUT HANDLE -- $e');
    }
  }

  Future<void>? signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await  FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential!=null && userCredential.user != null) {

        UserEntity mobilUserEntity = new UserEntity();
        if(userCredential.user!.displayName!=null){
          mobilUserEntity.name = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(0, userCredential.user!.displayName!.lastIndexOf(" ")) : userCredential.user!.displayName;
          mobilUserEntity.lastName = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(userCredential.user!.displayName!.lastIndexOf(" ")) : "";
        }
        mobilUserEntity.email = userCredential.user!.email;
        mobilUserEntity.password = userCredential.user!.uid;
        mobilUserEntity.id = userCredential.user!.uid;

        print('GELENN -- >>> ${mobilUserEntity.toJson()}');
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(AppPreferences.userTokenEntity, json.encode(mobilUserEntity.toJson()));
        sharedPreferences.setString(AppPreferences.identity, userCredential.user!.email!);
        sharedPreferences.setString(AppPreferences.password, userCredential.user!.uid);
        logedUserNotifier.value = mobilUserEntity;
        Navigator.pushNamed(context, AppRoutes.mainpageview);
      }
    }catch(e){
      print('SIGN IN ERROR GOOGLE -- $e');
    }
  }


  Future<String?> signInWithApple() async {
    try{
      final appleProvider = AppleAuthProvider();
      UserCredential userCredential = await  FirebaseAuth.instance.signInWithProvider(appleProvider);
      if (userCredential!=null && userCredential.user != null) {

        UserEntity mobilUserEntity = new UserEntity();
        if(userCredential.user!.displayName!=null){
          mobilUserEntity.name = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(0, userCredential.user!.displayName!.lastIndexOf(" ")) : userCredential.user!.displayName;
          mobilUserEntity.lastName = userCredential.user!.displayName!.contains(" ") ? userCredential.user!.displayName!.substring(userCredential.user!.displayName!.lastIndexOf(" ")) : "";
        }
        mobilUserEntity.email = userCredential.user!.email;
        mobilUserEntity.password = userCredential.user!.uid;
        mobilUserEntity.id = userCredential.user!.uid;

        print('GELENN -- >>> ${mobilUserEntity.toJson()}');
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString(AppPreferences.userTokenEntity, json.encode(mobilUserEntity.toJson()));
        sharedPreferences.setString(AppPreferences.identity, userCredential.user!.email!);
        sharedPreferences.setString(AppPreferences.password, userCredential.user!.uid);
        logedUserNotifier.value = mobilUserEntity;
        Navigator.pushNamed(context, AppRoutes.mainpageview);
      }
    }catch(e){
      print('SIGN IN ERROR APPLE -- $e');
    }
  }



}
