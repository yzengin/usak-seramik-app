// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';
import 'package:usak_seramik_app/View/widget/utility/picture_viewer.dart';

import '../../../../Rest/Entity/Product/product_detail_entity.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int dataId = 0;
  late ProductDetailData productDetailData;
  Set<String> uniqueSizes = Set<String>();
  Set<String> uniqueColor = Set<String>();
  Set<String> uniqueUsageArea = Set<String>();
  ValueNotifier<bool> hasLike = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        dataId = context.routeArguments![0];
        debugPrint('1-${context.routeArguments![0]}');
        debugPrint('2-${dataId}');

        Provider.of<ProductController>(context, listen: false).getProductByIdController(dataId).then((value) {});
      });
    } catch (e) {
      debugPrint('ProductDetailPage.initState() $e');
    }
  }

  void optimizing() {
    if (productDetailData != null && productDetailData.data != null) {
      if (productDetailData.data!.features != null) {
        productDetailData.data!.features!.forEach((element) {
          // SIZE OPTIMIZATION
          if (element.faceSizeId != null) {
            if (!uniqueSizes.contains(element.faceSizeId!.name)) {
              uniqueSizes.add(element.faceSizeId!.name!);
            }
          }

          // COLOR OPTIMIZATION
          if (element.faceColorId != null) {
            if (!uniqueColor.contains(element.faceColorId!.code)) {
              uniqueColor.add(element.faceColorId!.code!);
            }
          }

          // USAGE OPTIMIZATION
          // if (element.usageArea != null) {
          //   if (!uniqueColor.contains(element.usageArea!)) {
          //     uniqueColor.add(element.faceColorId!.code!);
          //   }
          // }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    productDetailData = Provider.of<ProductController>(context, listen: true).productDetailData;
    optimizing();
    debugPrint('3-${productDetailData.data?.toString()}');
    // hasLike = ValueNotifier<bool>(likedProduct.value.contains(data));
    return (productDetailData.data != null)
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                productDetailData.data!.name ?? "".toUpperCase(),
                style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontSize: 26),
              ),
              backgroundColor: context.theme.appBarTheme.backgroundColor!.withOpacity(.75),
              actions: [
                ValueListenableBuilder(
                    valueListenable: hasLike,
                    builder: (context, _, __) {
                      return IconButton(
                        onPressed: () {
                          // hasLike.value = !hasLike.value;
                          // if (hasLike.value) {
                          //   likedProduct.value.add(data);
                          //   appDialog(context, message: context.translete('favoriteAddedDialog'), dialogType: DialogType.success);
                          // } else {
                          //   likedProduct.value.remove(data);
                          // }
                        },
                        icon: (hasLike.value)
                            ? Icon(
                                FontAwesomeIcons.solidHeart,
                                color: AppColors.redS3,
                              )
                            : Icon(FontAwesomeIcons.heart),
                      );
                    })
              ],
            ),
            body: body(context),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: kToolbarHeight + context.paddingTop, bottom: 120),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (productDetailData.data != null) {
                if (productDetailData.data!.images != null) {
                  if (productDetailData.data!.images!.cover != null) {
                    pictureViewer(context, productDetailData.data!.images!.cover!);
                  }
                }
              }
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: (productDetailData.data != null)
                  ? (productDetailData.data!.images != null)
                      ? (productDetailData.data!.images!.cover != null)
                          ? Image.network(productDetailData.data!.images!.cover!)
                          : Center(child: CircularProgressIndicator())
                      : Center(child: CircularProgressIndicator())
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Animate(effects: [MoveEffect(begin: Offset(-50, 0), duration: 200.milliseconds)], child: Text(productDetailData.data?.name ?? "".toUpperCase(), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontSize: 26))).wrapPaddingHorizontal(20),
              Text(context.translete("productMainDescription"), style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 14)).wrapPaddingHorizontal(20),
              // Row(
              //   children: [
              //     Text(context.translete("productProperties"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
              //     Expanded(child: Text('FL', style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)).wrapPaddingLeft(20)),
              //   ],
              // ).wrapPaddingTop(20).wrapPaddingLeft(20),
              Row(
                children: [
                  Text(context.translete("colors"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: SizedBox(
                    height: kToolbarHeight * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueColor.length,
                      itemBuilder: (context, index) {
                        // final feature = productDetailData.data!.features?[index];
                        // if (feature != null) {
                        // if (feature.faceColorId != null) {
                        return SizedBox(height: kToolbarHeight * 0.5, width: kToolbarHeight, child: ColoredBox(color: uniqueColor.toList()[index].hexToColor())).wrapPaddingRight(10);
                        // }
                        // }
                      },
                    ).wrapPaddingLeft(20),
                  )),
                ],
              ).wrapPaddingTop(20).wrapPaddingLeft(20),
              Row(
                children: [
                  Text(context.translete("urunTuru"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
                  Expanded(child: Text('Takım Ürünleri', style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.w100)).wrapPaddingLeft(20)),
                ],
              ).wrapPaddingTop(20).wrapPaddingLeft(20),
              Row(
                children: [
                  Text(context.translete("sizes"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: SizedBox(
                    height: kToolbarHeight * 0.5 + 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueSizes.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: DecoratedBox(
                                decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  child: Text(uniqueSizes.toList()[index]),
                                )).wrapPaddingRight(10));
                      },
                    ).wrapPaddingLeft(20),
                  )),
                ],
              ).wrapPaddingTop(20).wrapPaddingLeft(20),
              Divider(),
              Text(context.translete('series'), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontSize: 26)).wrapPaddingLeft(20),
              // AspectRatio(
              //     aspectRatio: 0.75,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: (data.faceCount != null) ? data.faceCount! : 0,
              //       padding: EdgeInsets.only(left: 20),
              //       itemBuilder: (context, index) {
              //         // final face = data.face![index];
              //         // return SizedBox(
              //         //   width: context.width * 0.5,
              //         //   child: DecoratedBox(
              //         //     decoration: BoxDecoration(color: context.theme.colorScheme.surfaceTint.withOpacity(.25)),
              //         //     child: Column(
              //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //       children: [
              //         //         Flexible(
              //         //           child: AspectRatio(
              //         //             aspectRatio: double.parse(face.size.split('x')[0]) / double.parse(face.size.split('x')[1]),
              //         //             child: Image.network(
              //         //               face.image,
              //         //               alignment: Alignment.topCenter,
              //         //               fit: BoxFit.cover,
              //         //             ),
              //         //           ),
              //         //         ),
              //         //         Column(
              //         //           crossAxisAlignment: CrossAxisAlignment.start,
              //         //           mainAxisAlignment: MainAxisAlignment.end,
              //         //           children: [
              //         //             Text(face.title),
              //         //             Text(face.size, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w200)),
              //         //             SizedBox(
              //         //               height: kToolbarHeight * 0.5 + 20,
              //         //               child: ListView.builder(
              //         //                 scrollDirection: Axis.horizontal,
              //         //                 itemCount: face.properties.length,
              //         //                 itemBuilder: (context, index) {
              //         //                   final data = face.properties[index];
              //         //                   return Center(
              //         //                     child: DecoratedBox(
              //         //                       decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
              //         //                       child: Padding(
              //         //                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              //         //                         child: Text(data),
              //         //                       ),
              //         //                     ).wrapPaddingRight(10),
              //         //                   );
              //         //                 },
              //         //               ),
              //         //             ),
              //         //             Align(
              //         //               alignment: Alignment.centerRight,
              //         //               child: GestureDetector(
              //         //                   onTap: () {
              //         //                     appDialog(
              //         //                       context,
              //         //                       dialogType: DialogType.failed,
              //         //                       showButtonForChild: false,
              //         //                       child: SingleChildScrollView(
              //         //                         child: Column(
              //         //                           crossAxisAlignment: CrossAxisAlignment.start,
              //         //                           children: [
              //         //                             Padding(
              //         //                               padding: const EdgeInsets.all(8.0),
              //         //                               child: Align(
              //         //                                 alignment: Alignment.center,
              //         //                                 child: Column(
              //         //                                   children: [
              //         //                                     Text(face.title, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                     Text(face.size, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)),
              //         //                                   ],
              //         //                                 ),
              //         //                               ),
              //         //                             ),
              //         //                             Divider(),
              //         //                             Padding(
              //         //                               padding: const EdgeInsets.all(16.0),
              //         //                               child: Column(
              //         //                                 children: [
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("${context.translete('piece').toUpperCase()}/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('4.00', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                   Divider(),
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("M2/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('1.44', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                   Divider(),
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("M2/${context.translete('pallet').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('43.20', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                   Divider(),
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("${context.translete('box').toUpperCase()}/${context.translete('pallet').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('30.00', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                   Divider(),
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("KG/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('30.00', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                   Divider(),
              //         //                                   Row(
              //         //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //                                     children: [
              //         //                                       Text("${context.translete('palletSize').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              //         //                                       Text('80*120', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
              //         //                                     ],
              //         //                                   ),
              //         //                                 ],
              //         //                               ),
              //         //                             ),
              //         //                           ],
              //         //                         ),
              //         //                       ),
              //         //                     );
              //         //                   },
              //         //                   child: Text(
              //         //                     context.translete('info'),
              //         //                     style: context.theme.textTheme.bodyMedium!.copyWith(color: AppColors.blueS3),
              //         //                   ).wrapPaddingRight(10)),
              //         //             )
              //         //           ],
              //         //         ).wrapPaddingParametric(EdgeInsets.only(top: 10, left: 10, bottom: 10))
              //         //       ],
              //         //     ),
              //         //   ),
              //         // ).wrapPaddingRight(20);
              //       },
              //     )).wrapPaddingTop(20)
            ],
          ).wrapPaddingTop(20)
        ],
      ),
    );
  }
}
