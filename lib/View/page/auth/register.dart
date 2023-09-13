// ignore_for_file: library_private_types_in_public_api, unnecessary_new
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';
import 'package:usak_seramik_app/View/widget/utility/language_changer.dart';
import 'package:usak_seramik_app/View/widget/utility/title.dart';
import '../../../Controller/extension.dart';
import '../../../Controller/formatter.dart';
import '../../../Controller/localization.dart';
import '../../../Controller/notifiers.dart';
import '../../../Model/languages.dart';
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
          title: const Text('Kayıt Ol'),
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
                  TextFormField(
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [AppFormatter.phone],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: context.translete('phone')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.translete('emptyMessage');
                      } else if (value.replaceAll(' ', '').replaceAll('+90', '').toString().length < 10) {
                        return context.translete('phoneGreaterThan');
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
                              appDialog(context, message: 'success', dialogType: DialogType.success).then((value) => widget.switchCallback.call());
                            }
                          },
                          child: Text(context.translete('register')))
                      .wrapPaddingTop(20),
                  Divider().wrapPaddingTop(20),
                  ElevatedButton(
                          onPressed: () {
                            widget.switchCallback.call();
                          },
                          child: Text(context.translete('login')))
                      .wrapPaddingTop(20),
                ],
              ).wrapPaddingHorizontal(20),
            ),
          ),
        ),
      ),
    );
  }
}
