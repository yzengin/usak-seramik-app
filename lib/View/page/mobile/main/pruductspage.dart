import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/View/widget/drawer/filter_drawer.dart';
import '../../../../Controller/filter.dart';
import '../../../widget/drawer/contact_drawer.dart';
import '../../../widget/view/product_grid_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ProductAttributesSearch productAttributesSearch = ProductAttributesSearch(
            faceColorId: [],
            faceSizeId: [],
            faceSurfaceId: [],
            faceGlossId: [],
            faceThicknessId: [],
            faceStructureId: [],
            productTypeId: [],
            productUsagesId: []
        );
        Provider.of<ProductController>(context, listen: false).getProductController(productAttributesSearch).then((value) {
          setState(() {});
        });
      });
    } catch (e) {
      debugPrint('ProductsPage.initState() $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductData productData = Provider.of<ProductController>(context, listen: true).productData;
    return productData.data != null
        ? Scaffold(
            key: _key,
            extendBodyBehindAppBar: true,
            drawer: ContactDrawer(),
            endDrawer: FilterDrawer(model: testFilter, searchResultPage: false,),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: AppBar(
                    backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
                    title: Text(context.translete('products')),
                    actions: [
                      IconButton(
                          onPressed: () {
                            _key.currentState!.openEndDrawer();
                          },
                          icon: Icon(FontAwesomeIcons.filter)),
                    ],
                  ),
                ),
              ),
            ),
            body: body(context, productData),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget body(BuildContext context, ProductData productData) {
    return productData.data != null && productData.data!.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async => null,
            child: GridView.custom(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20 + AppBar().preferredSize.height + context.paddingTop,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = productData.data![index];
                  return ProductGridCard(data: data, index: index);
                },
                childCount: productData.data!.length,
              ),
              gridDelegate: SliverWovenGridDelegate.count(pattern: [
                WovenGridTile(1, alignment: AlignmentDirectional.center),
                WovenGridTile(5 / 7, crossAxisRatio: 0.9, alignment: AlignmentDirectional.bottomEnd),
              ], crossAxisSpacing: 0, mainAxisSpacing: 0, tileBottomSpace: 0, crossAxisCount: 2),
              shrinkWrap: true,
            ),
          )
        : Center(
            child: Text(context.translete('emptyProducts')),
          );
  }
}
