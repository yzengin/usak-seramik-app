import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/View/widget/drawer/filter_drawer.dart';
import '../../../../Controller/filter.dart';
import '../../../../Model/fake/product.dart';
import '../../../widget/drawer/contact_drawer.dart';

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
        Provider.of<ProductController>(context, listen: false).getProductController().then((value) {
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
    return productData!=null && productData.data!=null ? Scaffold(
            key: _key,
            extendBodyBehindAppBar: true,
            drawer: ContactDrawer(),
            endDrawer: FilterDrawer(model: testFilter),
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
          ): Center(child: CircularProgressIndicator(),);
  }

  Widget body(BuildContext context, ProductData productData) {
    return productData.data != null && productData.data!.isNotEmpty ? RefreshIndicator(
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
            return ProductCard(data: data, index: index);
          },
          childCount: productData.data!.length,
        ),
        gridDelegate: SliverWovenGridDelegate.count(pattern: [
          WovenGridTile(1, alignment: AlignmentDirectional.center),
          WovenGridTile(5 / 7, crossAxisRatio: 0.9, alignment: AlignmentDirectional.bottomEnd),
        ], crossAxisSpacing: 0, mainAxisSpacing: 0, tileBottomSpace: 0, crossAxisCount: 2),
        shrinkWrap: true,
      ),
    ): Center(child: Text("Ürün Listesi yok"),);
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, required this.index});
  final ProductEntity data;
  final int index;

  @override
  Widget build(BuildContext context) {
    Set<String> uniqueSizes = Set<String>();
    // data.face?.forEach((face) {
    //   uniqueSizes.add(face.size);
    // });
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.product_detail_page, arguments: [data]);
      },
      child: Animate(
          effects: [
            // TintEffect(begin: 1, end: 0),
            MoveEffect(begin: Offset(index % 2 == 0 ? -100 : 100, 0), end: Offset.zero)
          ],
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(imagePathControl(imageEntity: data.images!, cover: false)!, fit: BoxFit.cover),
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
                          data.name??"".toUpperCase(),
                          style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white, fontFamily: AppFont.oswald),
                        ),
                        Divider(thickness: 0.2, color: Colors.white, height: 3),
                        Text(
                          '${data.faceCount} FACE ${data.colorCount} RENK ${uniqueSizes.length} EBAT',
                          style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white, fontFamily: AppFont.oswald, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  String? imagePathControl({ImagesClass? imageEntity, bool? cover}){
    try{
      if(imageEntity!.thumb!=null && !cover!){
        return imageEntity.thumb;
      }else {
        return imageEntity.cover;
      }
    }catch(e){
      return "notImage";
    }

  }
}
