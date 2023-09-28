import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/like_helper.dart';
import 'package:usak_seramik_app/View/page/mobile/detail/cart_form_detail_page.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';

import '../../../../Controller/asset.dart';
import '../../../../Controller/preferences.dart';
import '../../../../Rest/Entity/Product/product_entity.dart';
import '../../../widget/view/product_grid_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductEntity> cartList = [];

  @override
  void initState() {
    likePreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(context.translete('cart')), backgroundColor: context.theme.appBarTheme.backgroundColor!.withOpacity(.5)),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return (cartList != null)
        ? (cartList.length > 0)
            ? Scaffold(
                bottomNavigationBar: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CartFormPage(),
                        ));
                  },
                  child: Text(context.translete('order')),
                ).wrapPaddingParametric(EdgeInsets.only(
                  bottom: context.paddingBottomPlace,
                  left: 20,
                  right: 20,
                )),
                body: RefreshIndicator(
                  onRefresh: () async => likePreferences(),
                  child: SizedBox.expand(
                    // ignore: unnecessary_null_comparison
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: kToolbarHeight + context.paddingTop + 20, left: 20, right: 20, bottom: 120),
                      physics: AlwaysScrollableScrollPhysics(),
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
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              AppCartHelper.cartToggle(data, remove: true).then((value) {
                                                likePreferences();
                                              });
                                            },
                                            icon: Icon(FontAwesomeIcons.minus, color: AppColors.redS6),
                                          )
                                        ],
                                      )
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
                  ),
                ),
              )
            : Center(
                child: Text(context.translete('emptyCart')),
              )
        : Center(
            child: Text(context.translete('emptyCart')),
          );
  }

  // ---------------------------------------------------------------------------------------------------
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
