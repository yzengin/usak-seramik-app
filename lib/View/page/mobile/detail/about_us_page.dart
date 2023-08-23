import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translete('aboutUs'))),
      body: body(context),
    );
  }

  body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120),
      child: Column(
        children: [
          Image.network('https://usakseramik.com/storage/photos/1/kurumsal-small.png').wrapPaddingBottom(20),
          FutureBuilder(
            future: localeNotifier.value!.languageCode == 'tr' ? DefaultAssetBundle.of(context).loadString(AppData.aboutTr) : DefaultAssetBundle.of(context).loadString(AppData.aboutEn),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(md.Markdown(data: snapshot.data ?? "").data);
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
