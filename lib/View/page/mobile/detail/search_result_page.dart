import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
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
              title: context.routeArguments?[0] != null ? Text(context.translete('searchResult') + "\n" + context.translete(context.routeArguments![0]),textAlign: TextAlign.center) : Text(context.translete('searchResult'), textAlign: TextAlign.center),
              actions: [],
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
          // return ProductCard(data: data, index: index);
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
