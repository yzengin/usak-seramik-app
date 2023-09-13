// ignore_for_file: library_private_types_in_public_api, unnecessary_new
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Controller/theme.dart';
import 'package:usak_seramik_app/View/widget/utility/theme_changer.dart';
import '../../../Controller/extension.dart';
import '../../../Controller/localization.dart';
import '../../../Controller/notifiers.dart';
import '../../../Model/languages.dart';
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
          title: Image.asset(AppImage.logotype, width: context.width * 0.6, color: context.theme.appBarTheme.backgroundColor!.getContrastColor()),
          toolbarHeight: kToolbarHeight * 3,
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
                  decoration: InputDecoration(
                    labelText: context.translete('password'),
                  ),
                ).wrapPaddingTop(20),
                ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.mainpageview);
                        },
                        child: Text(context.translete('login')))
                    .wrapPaddingTop(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppleAuthButton(
                      style: AuthButtonStyle(buttonType: AuthButtonType.icon, iconColor: context.theme.iconTheme.color, buttonColor: Colors.transparent),
                      darkMode: Provider.of<ThemeController>(context, listen: true).isDark,
                    ),
                    GoogleAuthButton(
                      style: AuthButtonStyle(buttonType: AuthButtonType.icon, iconColor: context.theme.iconTheme.color, buttonColor: Colors.transparent),
                      darkMode: !Provider.of<ThemeController>(context, listen: true).isDark,
                    ),
                  ],
                ).wrapPaddingTop(20),
                Text(context.translete('notRegister')).wrapPaddingTop(40),
                ElevatedButton(
                        onPressed: () {
                          widget.switchCallback.call();
                        },
                        child: Text(context.translete('register')))
                    .wrapPaddingTop(20),
              ],
            ).wrapPaddingHorizontal(20),
          ),
        ),
      ),
    );
  }
}
