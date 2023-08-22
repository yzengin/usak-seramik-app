import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/View/widget/drawer/filter_drawer.dart';
import '../../../../Controller/filter.dart';
import '../../../../Model/fake/product.dart';
import '../main/pruductspage.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
              title: Text(context.translete('searchResult')),
              actions: [
              ],
            ),
          ),
        ),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return GridView.custom(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20 + AppBar().preferredSize.height + context.paddingTop,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final data = productList[index];
          return ProductCard(data: data, index: index);
        },
        childCount: productList.length,
      ),
      gridDelegate: SliverWovenGridDelegate.count(pattern: [
        WovenGridTile(1, alignment: AlignmentDirectional.center),
        WovenGridTile(5 / 7, crossAxisRatio: 0.9, alignment: AlignmentDirectional.bottomEnd),
      ], crossAxisSpacing: 0, mainAxisSpacing: 0, tileBottomSpace: 0, crossAxisCount: 2),
      shrinkWrap: true,
    );
  }
}
