import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';

import '../../../../Controller/preferences.dart';
import '../../../widget/view/product_grid_widget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<ProductEntity> likedList = [];
  @override
  void initState() {
    likePreferences();
    super.initState();
  }

  void likePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList(AppPreferences.favorites) == null) {
      await preferences.setStringList(AppPreferences.favorites, []).then((value) {});
    }
    List<String>? fetch = preferences.getStringList(AppPreferences.favorites);
    fetch!.forEach((element) {
      ProductEntity product = ProductEntity.fromJson(json.decode(element));
      likedList.add(product);
    });
    debugPrint('${likedList.length.toString()}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(context.translete('favorites')), backgroundColor: context.theme.appBarTheme.backgroundColor!.withOpacity(.5)),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => null,
      child: SizedBox.expand(
        // ignore: unnecessary_null_comparison
        child: (likedList != null)
            ? (likedList.length > 0)
                ? GridView.custom(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20 + context.paddingTop,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final data = likedList[index];
                        debugPrint('${data.name}');
                        return ProductGridCard(data: data, index: index, showInfo: false);
                      },
                      childCount: likedList.length,
                    ),
                    gridDelegate: SliverWovenGridDelegate.count(pattern: [
                      WovenGridTile(1, alignment: AlignmentDirectional.center),
                      WovenGridTile(5 / 7, crossAxisRatio: 0.9, alignment: AlignmentDirectional.bottomEnd),
                    ], crossAxisSpacing: 0, mainAxisSpacing: 0, tileBottomSpace: 0, crossAxisCount: 2),
                    shrinkWrap: true,
                  )
                : Center(
                    child: Text(context.translete('emptyFavourite')),
                  )
            : Center(
                child: Text(context.translete('emptyFavourite')),
              ),
      ),
    );
  }
}
