import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/formatter.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Model/fake/address.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import 'package:usak_seramik_app/View/widget/sheet/app_bottomsheet.dart';
import 'package:usak_seramik_app/View/widget/utility/copy_on_tap.dart';
import 'package:usak_seramik_app/View/widget/utility/language_changer.dart';

import '../../../../Controller/controller.dart';
import '../../../widget/drawer/appdrawer.dart';

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
      drawer: AppDrawer(),
      bottomSheet: AppBottomSheet(
        title: context.translete('contactForm'),
        icon: FontAwesomeIcons.envelope,
        maxSize: 1,
        child: ContactFormSheet(),
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
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 120
        ),
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
        return Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.translete(data.title).toUpperCase()).wrapPaddingHorizontal(10),
                Divider(color: context.theme.dividerColor.withOpacity(.25)),
                GestureDetector(
                  onTap: () async => launchMapsUrl(data.latitute, data.longtitute),
                  child: Row(children: [
                    Icon(FontAwesomeIcons.locationDot, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10),
                    Expanded(child: Text(data.address, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                ),
                GestureDetector(
                  onTap: () async => launchPhone(data.phone),
                  child: Row(children: [
                    Icon(FontAwesomeIcons.phone, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10),
                    Expanded(child: Text(data.phone, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                ),
                GestureDetector(
                  onTap: () async => launchMail(data.email),
                  child: Row(children: [
                    Icon(FontAwesomeIcons.fax, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10),
                    Expanded(child: Text(data.fax, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                  ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                ),
                Row(children: [
                  Icon(FontAwesomeIcons.solidEnvelope, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10),
                  Expanded(child: Text(data.email, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContactFormSheet extends StatelessWidget {
  ContactFormSheet({
    super.key,
  });
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: context.translete('name')),
          ).wrapPaddingBottom(20),
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: context.translete('email')),
          ).wrapPaddingBottom(20),
          TextField(
            controller: phoneController,
            textInputAction: TextInputAction.next,
            inputFormatters: [AppFormatter.phone],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.translete('phone')),
          ).wrapPaddingBottom(20),
          TextField(
            controller: subjectController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: context.translete('subject')),
          ).wrapPaddingBottom(20),
          TextField(
            controller: messageController,
            textInputAction: TextInputAction.done,
            inputFormatters: [],
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(labelText: context.translete('message')),
          ).wrapPaddingBottom(20),
          ElevatedButton(onPressed: () {}, child: Text(context.translete('send')))
        ],
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
                          onPressed: () {},
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
