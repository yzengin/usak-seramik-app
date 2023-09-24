// ignore_for_file: library_private_types_in_public_api, unnecessary_new
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';
import '../../../Controller/auth_error.dart';
import '../../../Controller/controller.dart';
import '../../../Controller/extension.dart';
import '../../../Controller/formatter.dart';
import '../../../Controller/localization.dart';
import '../../../Controller/notifiers.dart';
import '../../../Controller/preferences.dart';
import '../../../Controller/routes.dart';
import '../../../Model/languages.dart';
import '../../../Rest/Entity/User/user_entity.dart';
import '../../widget/utility/copy_on_tap.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.switchCallback}) : super(key: key);
  final VoidCallback switchCallback;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordVerifyController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(context.translete('register')),
          leading: IconButton(onPressed: () => widget.switchCallback.call(), icon: Icon(FontAwesomeIcons.chevronLeft)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CopyOnTap(
                    languageList().where((element) => element.locale.languageCode != localeNotifier.value!.languageCode).first.title,
                    callback: () => Provider.of<LocalizationController>(context, listen: false).set(localeNotifier.value!.languageCode == 'tr' ? languageList()[1].locale : languageList().first.locale),
                  ).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.background, fontSize: 14))
                ],
              ),
            ),
          ],
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            child: Form(
              key: _formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.translete('personalInformation'), style: context.textStyle.copyWith(fontSize: 27)).wrapPaddingBottom(20),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: context.translete('name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.translete('emptyMessage');
                      } else if (value.length < 2) {
                        return context.translete('nameGreaterThan');
                      }
                      return null;
                    },
                  ).wrapPaddingBottom(20),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: context.translete('email')),
                    validator: (value) {
                      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (value == null || value.isEmpty) {
                        return context.translete('emptyMessage');
                      } else if (!emailRegex.hasMatch(value)) {
                        return context.translete('emailValidation');
                      }

                      return null;
                    },
                  ).wrapPaddingBottom(20),
                  Text(
                    context.translete('password'),
                    style: context.textStyle.copyWith(fontSize: 27),
                  ).wrapPaddingBottom(20),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: context.translete('password')),
                    validator: (value) {
                      return null;
                    },
                  ).wrapPaddingBottom(20),
                  TextFormField(
                    controller: _passwordVerifyController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: context.translete('passwordVerify')),
                    validator: (value) {
                      return null;
                    },
                  ).wrapPaddingBottom(20),
                  ElevatedButton(
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              registerFirebase(_emailController.text, _passwordController.text, _nameController.text);
                            }
                          },
                          child: Text(context.translete('register')))
                      .wrapPaddingTop(20),
                  // Divider().wrapPaddingTop(20),
                  // ElevatedButton(
                  //         onPressed: () {
                  //           widget.switchCallback.call();
                  //         },
                  //         child: Text(context.translete('login')))
                  //     .wrapPaddingTop(20),
                ],
              ).wrapPaddingHorizontal(20),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerFirebase(String emailAddress, String password, String fullName) async{
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (userCredential!=null && userCredential.user != null) {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        User? currentUser = await _auth.currentUser;
        currentUser?.updateDisplayName("$fullName");
        appDialog(context, message: context.translete('success'), dialogType: DialogType.success).then((value) => loginFirebaseEmailAndPassword(emailAddress, password));
      }
    } on FirebaseAuthException catch (e) {
        firebaseDialogSwitch(e, context);
    } catch (e) {
      print(e);
    }
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
}
