import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import '../../../../Controller/launcher.dart';
import '../../../../Model/fake/seller.dart';
import '../../../widget/drawer/contact_drawer.dart';
import '../../../widget/sheet/contactForm_bottomsheet.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        final data = addressList[index];
        return AddressCard(data: data, titleTranslate: true);
      },
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.data, this.titleTranslate = false});
  final bool titleTranslate;
  final Point data;

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
              Text((titleTranslate) ? context.translete(data.title).toUpperCase() : data.title).wrapPaddingHorizontal(10),
              Divider(color: context.theme.dividerColor.withOpacity(.25)),
              GestureDetector(
                onTap: () async => launchMapsUrl(data.coordinate.latitude, data.coordinate.longitude),
                child: Row(children: [
                  Expanded(child: Text(data.address, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('getRoute'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.locationArrow, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              GestureDetector(
                onTap: () async => launchPhone(data.phone),
                child: Row(children: [
                  Expanded(child: Text(data.phone, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('call'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.phone, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              GestureDetector(
                onTap: () async => launchMail(data.email ?? ""),
                child: Row(children: [
                  Expanded(child: Text(data.fax, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  Row(
                    children: [
                      Text(context.translete('fax'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                      Icon(FontAwesomeIcons.fax, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                    ],
                  ),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ),
              (data.email == null)
                  ? SizedBox()
                  : Row(children: [
                      Expanded(child: Text(data.email!, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                      Row(
                        children: [
                          Text(context.translete('email'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                          Icon(FontAwesomeIcons.solidEnvelope, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                        ],
                      ),
                    ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
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
        aspectRatio: 3,
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
                      child: Text(logedUserNotifier.value!.name!.head()).wrapTextStyle(context.theme.textTheme.bodySmall!.copyWith(fontSize: 20)),
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
                          TextSpan(text: context.translete('welcome') + " ", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                          TextSpan(text: logedUserNotifier.value!.name, style: context.theme.textTheme.bodyMedium),
                        ])),
                        CupertinoButton(
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
