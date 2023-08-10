import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/localization.dart';
import 'package:usak_seramik_app/Model/languages.dart';
import 'package:usak_seramik_app/View/widget/dialog/sheet.dart';
import 'package:usak_seramik_app/View/widget/utility/copy_on_tap.dart';
import 'package:usak_seramik_app/View/widget/utility/language_changer.dart';
import 'package:usak_seramik_app/View/widget/utility/theme_changer.dart';

import '../../../Controller/notifiers.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(AppImage.logotype, fit: BoxFit.fitWidth, color: context.theme.colorScheme.surface),
                    ),
                  ),
                  Text("v1.0.0", style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.background)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeChangerButton(),
                CopyOnTap(
                  languageList().where((element) => element.locale.languageCode != localeNotifier.value!.languageCode).first.title,
                  callback: () => Provider.of<LocalizationController>(context, listen: false).set(localeNotifier.value!.languageCode == 'tr' ? languageList()[1].locale : languageList().first.locale),
                ).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.background))
              ],
            ),
          ),
          // LanguageChangerButton(
          //   callback: () {
          //     setState(() {});
          //   },
          // )
        ],
      ),
    );
  }
}
