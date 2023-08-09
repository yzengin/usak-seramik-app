import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/View/widget/utility/language_changer.dart';

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
        leading: IconButton(onPressed: () => scaffoldState.currentState!.openDrawer(), icon: Image.asset(AppImage.logo, color: context.theme.colorScheme.surface)),
      ),
      body: body(context),
      drawer: AppDrawer(),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AspectRatio(
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
                            radius: 200,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(text: TextSpan(
                              children: [
                                TextSpan(text: context.translete('welcome') + " ", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
                                TextSpan(text: logedUserNotifier.value!.name, style: context.theme.textTheme.bodyMedium),
                              ]
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          )
        ],
      ),
    );
  }
}
