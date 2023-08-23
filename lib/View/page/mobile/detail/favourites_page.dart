import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';

import '../main/pruductspage.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
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
        child: ValueListenableBuilder(
          valueListenable: likedProduct,
          builder: (context,_,__) {
            return GridView.custom(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20 + context.paddingTop,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = likedProduct.value[index];
                  return ProductCard(data: data, index: index);
                },
                childCount: likedProduct.value.length,
              ),
              gridDelegate: SliverWovenGridDelegate.count(pattern: [
                WovenGridTile(1, alignment: AlignmentDirectional.center),
                WovenGridTile(5 / 7, crossAxisRatio: 0.9, alignment: AlignmentDirectional.bottomEnd),
              ], crossAxisSpacing: 0, mainAxisSpacing: 0, tileBottomSpace: 0, crossAxisCount: 2),
              shrinkWrap: true,
            );
          }
        ),
      ),
    );
  }
}
