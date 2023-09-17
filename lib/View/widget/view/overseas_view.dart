import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/extension.dart';


class OverseasView extends StatelessWidget {
  OverseasView({super.key});
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
              title: Text(context.translete('stores')),
              bottom: PreferredSize(
                  child: DefaultTabController(
                    length: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ['domestic', 'overseas']
                          .map((e) => GestureDetector(
                              onTap: () {
                                if (e == 'domestic') {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                context.translete(e),
                                style: context.textStyle.copyWith(color: e == 'overseas' ? context.textStyle.color : context.textStyle.color!.withOpacity(.5)),
                              ).wrapPaddingHorizontal(10)))
                          .toList(),
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight * 0.5)),
            ),
          ),
        ),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    List<String> ulkeler = [
      "ABD",
      "ALMANYA",
      "ANGOLA",
      "ARJANTIN",
      "ARNAVUTLUK",
      "AZERBAYCAN",
      "BOSNA",
      "BULGARİSTAN",
      "ÇEK CUMHURİYETİ",
      "FİLDİŞİ",
      "FRANSA",
      "GAMBİA",
      "GÜRCİSTAN",
      "IRAK",
      "İNGİLTERE",
      "İSRAİL",
      "İSVEÇ",
      "KANADA",
      "KIBRIS",
      "KOSOVA",
      "MAKEDONYA",
      "MALİ",
      "MALTA",
      "POLANYA",
      "ROMANYA",
      "SENEGAL",
      "SIRBISTAN",
      "ŞİLİ",
      "TÜRKMENİSTAN",
      "UGANDA",
      "YUNANİSTAN",
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.network('https://www.usakseramik.com/img/overseas_salespoints.jpg'),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20),
            itemCount: ulkeler.length,
            itemBuilder: (context, index) {
              final data = ulkeler[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.textStyle.color!.withOpacity(.25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                        ).wrapPaddingHorizontal(10),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(border: Border.all(color: context.textStyle.color!)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data),
                      ),
                    ),
                  ],
                ),
              ).wrapPaddingBottom(20);
            },
          )
        ],
      ),
    );
  }
}
