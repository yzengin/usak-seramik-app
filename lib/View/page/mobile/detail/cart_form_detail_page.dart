import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/like_helper.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Model/entry.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';
import 'package:usak_seramik_app/View/widget/entry_view.dart';

import '../../../../Controller/asset.dart';
import '../../../../Controller/preferences.dart';
import '../../../../Controller/routes.dart';
import '../../../../Rest/Entity/Product/product_entity.dart';
import '../../../../view/style/colors.dart';
import '../../../widget/view/product_grid_widget.dart';

class CartFormPage extends StatefulWidget {
  const CartFormPage({super.key});

  @override
  State<CartFormPage> createState() => _CartFormPageState();
}

class _CartFormPageState extends State<CartFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<ProductEntity> cartList = [];

  @override
  void initState() {
    super.initState();
    likePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(context.translete('orderForm')), backgroundColor: context.theme.appBarTheme.backgroundColor!.withOpacity(.5)),
      body: body(context),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          appDialog(context, message: context.translete('orderSuccess'), dialogType: DialogType.success).then((value) {
            AppCartHelper.cartClean().then((value) {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainpageview, (route) => false);
            });
          });
        },
        child: Text(context.translete('send')),
      ).wrapPaddingParametric(EdgeInsets.only(
        bottom: context.paddingBottomPlace,
        left: 20,
        right: 20,
      )),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: kToolbarHeight + context.paddingTop + 20, left: 20, right: 20, bottom: context.paddingBottomPlace + 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryView(entry: EntryData(key: context.translete('orderNo'), data: '${logedUserNotifier.value?.name?[0].toUpperCase()}${logedUserNotifier.value?.email?[0].toUpperCase()}${Random().nextInt(100)}${findUppercaseASCII(List.generate(2, (index) => Random().nextInt(25) + 65))}')),
          EntryView(entry: EntryData(key: context.translete('name'), data: '${logedUserNotifier.value?.name?.toUpperCase()} ${logedUserNotifier.value?.lastName?.toUpperCase()}')),
          EntryView(entry: EntryData(key: context.translete('email'), data: '${logedUserNotifier.value?.email}')),
          Text(context.translete('yourOrder')).wrapPaddingVertical(20),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = cartList[index];
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        AspectRatio(aspectRatio: 1, child: ProductGridCard(data: data, index: index, showInfo: false, forCart: true)),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(text: "${data.name}", style: context.textStyle.copyWith(fontFamily: AppFont.oswald, fontSize: 14)),
                              TextSpan(text: "${data.faceCount} ${context.translete('face').toUpperCase()} ${data.colorCount} ${context.translete('color').toUpperCase()} ${data.sizeCount} ${context.translete('dimension').toUpperCase()}", style: context.textStyle.copyWith(fontFamily: AppFont.oswald, fontSize: 11)),
                            ])).wrapPaddingLeft(10),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Divider()
                ],
              );
            },
            itemCount: cartList.length,
          ),
          Text(context.translete('orderDescription'), style: context.textStyle.copyWith(fontSize: 11))
        ],
      ),
    );
  }

  String findUppercaseASCII(List<int> intList) {
    String uppercaseList = "";

    for (int code in intList) {
      if (code >= 65 && code <= 90) {
        // Büyük harf ASCII kodları A-Z için 65-90 arasındadır.
        uppercaseList = uppercaseList + String.fromCharCode(code);
      }
    }

    return uppercaseList;
  }

  void likePreferences() async {
    debugPrint('runnnn');
    cartList.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList(AppPreferences.cart) == null) {
      await preferences.setStringList(AppPreferences.cart, []).then((value) {});
    }
    List<String>? fetch = preferences.getStringList(AppPreferences.cart);
    fetch!.forEach((element) {
      ProductEntity product = ProductEntity.fromJson(json.decode(element));
      cartList.add(product);
    });
    debugPrint('${cartList.length.toString()}');
    setState(() {});
  }
}
