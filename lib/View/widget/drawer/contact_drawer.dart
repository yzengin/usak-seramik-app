import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/localization.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Model/languages.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_features_controller.dart';
import 'package:usak_seramik_app/View/widget/utility/copy_on_tap.dart';
import 'package:usak_seramik_app/View/widget/utility/theme_changer.dart';

import '../../../Controller/notifiers.dart';
import '../../../Controller/preferences.dart';
import '../../../Rest/Entity/User/user_entity.dart';
import '../dialog/dialog.dart';

class ContactDrawer extends StatelessWidget {
  const ContactDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('${localeNotifier.value!.languageCode}');
    return Drawer(
      // width: context.width * 0.75,
      child: Padding(
        padding: EdgeInsets.only(top: context.paddingTop * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(AppImage.logotype, fit: BoxFit.fitWidth, color: context.theme.colorScheme.onTertiary).wrapPaddingAll(20).wrapPaddingBottom(20),
                ListTile(title: Text(context.translete('aboutUs')), onTap: () => Navigator.pushNamed(context, AppRoutes.about_us_page)),
                ListTile(title: Text(context.translete('inventorRelations')), onTap: () => Navigator.pushNamed(context, AppRoutes.webview_page, arguments: [localeNotifier.value?.languageCode == 'tr' ? "https://www.usakseramik.com/yatirimci-iliskileri/degerleme-raporlari" : "https://www.usakseramik.com/en/investor-relations/valuation-reports", context.translete('inventorRelations'), false])),
                ListTile(title: Text(context.translete('visionMission')), onTap: () => Navigator.pushNamed(context, AppRoutes.webview_page, arguments: [localeNotifier.value?.languageCode == 'tr' ? "https://www.usakseramik.com/kurumsal/misyon-vizyon" : "https://www.usakseramik.com/en/corporate/vision-mission",context.translete('visionMission'), false])),
                ListTile(title: Text(context.translete('history')), onTap: () => Navigator.pushNamed(context, AppRoutes.webview_page, arguments: [localeNotifier.value?.languageCode == 'tr' ? "https://www.usakseramik.com/kurumsal/tarihce" : "https://www.usakseramik.com/en/corporate/history",context.translete('history'), false])),
                ListTile(title: Text(context.translete('deleteAccount')),
                    onTap: (){
                      appDialog(context, message: context.translete('deleteAccountText'), dialogType: DialogType.warning).then((value){
                        if (value!=null && value) {
                          SharedPreferences.getInstance().then((prefs) async {
                            if (prefs.containsKey(AppPreferences.identity) || prefs.containsKey(AppPreferences.password)) {
                              prefs.remove(AppPreferences.identity);
                              prefs.remove(AppPreferences.password);
                            }
                            prefs.remove(AppPreferences.userTokenEntity).then((value) async {
                              if (value) {
                                // notificationFCMCloseSubscribe();
                                try{
                                  await GoogleSignIn().disconnect();
                                  await FirebaseAuth.instance.signOut();
                                }catch(e){
                                  print('ERROR SIGN OUT HANDLE -- $e');
                                }
                                logedUserNotifier.value = UserEntity();
                              }
                            });
                          });
                          Navigator.pushNamedAndRemoveUntil(context, 'app_starter', (route) => false);
                        }
                      });
                    }
                ),
              ],
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
                  ).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.background, fontSize: 14))
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
      ),
    );
  }
}
