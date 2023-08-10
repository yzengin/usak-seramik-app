import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

import '../../../../Model/fake/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
              title: Text(context.translete('products')),
              actions: [IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.filter))],
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

    // itemCount: productList.length,
    // itemBuilder: (context, index) {
    //   final data = productList[index];
    //   return Image.asset(data.image, fit: BoxFit.cover);
    // },
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, required this.index});
  final Product data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: [
          // TintEffect(begin: 1, end: 0),
          MoveEffect(begin: Offset(index % 2 == 0 ? -100 : 100, 0), end: Offset.zero)
        ],
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(data.image, fit: BoxFit.cover),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black.withOpacity(.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name.toUpperCase(),
                        style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white, fontFamily: AppFont.oswald),
                      ),
                      Divider(thickness: 0.2, color: Colors.white, height: 3),
                      Text(
                        '1 FACE 2 RENK 1 EBAT',
                        style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white, fontFamily: AppFont.oswald, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
