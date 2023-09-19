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
  ScrollController scrollController = ScrollController();
  List<ProductEntity>? productData;
  int page = 0;

  @override
  void initState() {
    super.initState();
    ProductAttributesSearch productAttributesSearch = ProductAttributesSearch(
      faceColorId: [],
      faceSizeId: [],
      faceSurfaceId: [],
      faceGlossId: [],
      faceThicknessId: [],
      faceStructureId: [],
      productTypeId: [],
      productUsagesId: [],
    );
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollController.addListener(() {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent && context.isMobile) {
            Provider.of<ProductController>(context, listen: false).getProductController(productAttributesSearch, page: ++page).then((value) {
              setState(() {});
            });
          }
        });
        Provider.of<ProductController>(context, listen: false).getProductController(productAttributesSearch, page: page).then((value) {
          setState(() {});
        });
      });
    } catch (e) {
      debugPrint('ProductsPage.initState() $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    productData = Provider.of<ProductController>(context, listen: true).productList;
    return (productData != null)
        ? Scaffold(
            key: _key,
            extendBodyBehindAppBar: true,
            drawer: ContactDrawer(),
            endDrawer: FilterDrawer(
              model: testFilter,
              searchResultPage: false,
            ),
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
            body: body(context),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget body(BuildContext context) {
    return productData != null && productData!.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async => null,
            child: GridView.custom(
              controller: scrollController,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20 + AppBar().preferredSize.height + context.paddingTop,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = productData![index];
                  return ProductGridCard(data: data, index: index);
                },
                childCount: productData!.length,
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
