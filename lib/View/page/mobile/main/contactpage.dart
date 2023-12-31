import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Controller/User/contact_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/User/contact_entity.dart';
import 'package:usak_seramik_app/View/widget/utility/copy_on_tap.dart';
import '../../../../Controller/launcher.dart';
import '../../../../Controller/preferences.dart';
import '../../../../Rest/Entity/User/user_entity.dart';
import '../../../../Rest/Handler/auth_handler.dart';
import '../../../widget/dialog/dialog.dart';
import '../../../widget/drawer/contact_drawer.dart';
import '../../../widget/sheet/contactForm_bottomsheet.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  late ContactData contactData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contactData = Provider.of<ContactController>(context, listen: true).contactData;
    return (contactData.data == null) ? SizedBox() : Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: IconButton(onPressed: () => scaffoldState.currentState!.openDrawer(), icon: Icon(FontAwesomeIcons.bars, color: context.theme.colorScheme.surface)),
        actions: [
          Image.asset(AppImage.logo, width: context.theme.iconTheme.size, color: context.theme.iconTheme.color).wrapPaddingRight(10),
        ],
        title: Text(context.translete('contact')),
      ),
      body: body(context),
      drawer: ContactDrawer(),
      bottomSheet: ContactFormBottomSheet(
        title: context.translete('contactForm'),
        icon: FontAwesomeIcons.solidEnvelope,
        maxSize: 1,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(FontAwesomeIcons.envelope),
      // ),
    );
  }

  Widget body(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120),
        child: Column(
          children: [
            ProfileCard(),
            Text(
              context.translete('contactUs'),
              style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.surfaceTint),
            ).wrapPaddingVertical(10),
            addressView(),
          ],
        ),
      ),
    );
  }

  Widget addressView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: contactData.data!.length,
      itemBuilder: (context, index) {
        final data = contactData.data![index];
        return AddressCard(data: data, titleTranslate: true);
      },
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.data, this.titleTranslate = false});
  final bool titleTranslate;
  final ContactEntity data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((data.title != null) ? data.title!.toUpperCase() : "").wrapPaddingHorizontal(10),
              Divider(color: context.theme.dividerColor.withOpacity(.25)),
              GestureDetector(
                onTap: () async => launchMapsUrl((data.lat != null) ? double.parse(data.lat!) : 0, (data.lng != null) ? double.parse(data.lng!) : 0),
                child: Row(children: [
                  Expanded(child: Text(data.address??"", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('getRoute'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.locationArrow, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              GestureDetector(
                onTap: () async => launchPhone((data.tel != null) ? data.tel!  : ""),
                child: Row(children: [
                  Expanded(child: Text((data.tel != null) ? data.tel!  : "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('call'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.phone, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              GestureDetector(
                onTap: () async => launchPhone((data.tel2 != null) ? data.tel2!  : ""),
                child: Row(children: [
                  Expanded(child: Text((data.tel2 != null) ? data.tel2!  : "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('call'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.phone, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              Row(children: [
                Expanded(child: Text((data.fax != null) ? data.fax!  : "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                CopyOnTap(
                  '${data.fax}',
                  delay: 1.second(),
                  child: Row(
                    children: [
                      Text(context.translete('fax'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.fax, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ),
              ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              (data.email == null)
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () async => launchMail(data.email ?? ""),
                      child: Row(children: [
                        Expanded(child: Text(data.email!, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                        Row(
                          children: [
                            Text(context.translete('email'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                            Icon(FontAwesomeIcons.solidEnvelope, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                          ],
                        ),
                      ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2.6,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor: context.theme.colorScheme.surfaceTint,
                      child: Text(displayNameGetControl(context, nameFirstCharacter: true)!).wrapTextStyle(context.theme.textTheme.bodySmall!.copyWith(fontSize: 20)),
                      radius: 200,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: context.translete('welcome') + ", ${displayNameGetControl(context, nameFirstCharacter: false)}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                        ])),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.favourites_page);
                            },
                            padding: EdgeInsets.zero,
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.heart, color: context.theme.colorScheme.surfaceVariant, size: context.theme.iconTheme.size! * 0.7).wrapPaddingRight(4),
                                Text(context.translete('favorites')).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.surfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async {
                              appDialog(context, message: context.translete('logoutText')).then((value) {
                                if (value) {
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
                            },
                            padding: EdgeInsets.zero,
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.doorClosed, color: context.theme.colorScheme.surfaceVariant, size: context.theme.iconTheme.size! * 0.7).wrapPaddingRight(4),
                                Text(context.translete('logout')).wrapTextStyle(context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.surfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String? displayNameGetControl(BuildContext context, {required bool nameFirstCharacter}){
    String displayName = context.translete('guest');
    if(logedUserNotifier.value!=null && logedUserNotifier.value!.id!=null){
      if(logedUserNotifier.value!.name!=null){
        if(nameFirstCharacter){
          displayName = logedUserNotifier.value!.name!.head();
        }else{
          displayName = logedUserNotifier.value!.name!;
        }
      }else{
        if(nameFirstCharacter){
          String comingData = displayName;
          displayName = comingData.head().firstLetterUpperCase();
        }
      }
    }else{
      if(nameFirstCharacter){
        String comingData = displayName;
        displayName = comingData.head().firstLetterUpperCase();
      }else{
        return displayName;
      }
    }
    return displayName;
  }
}
