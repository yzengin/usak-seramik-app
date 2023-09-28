// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/controller.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/like_helper.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';
import 'package:usak_seramik_app/View/widget/utility/picture_viewer.dart';

import '../../../../Rest/Entity/Product/ProductFeatures/name_data_entity.dart';
import '../../../../Rest/Entity/Product/product_detail_entity.dart';
import '../../../../Rest/Entity/Product/product_entity.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int dataId = 0;
  ProductEntity data = ProductEntity();
  ProductDetailData productDetailData = ProductDetailData();
  Set<String> uniqueSizes = Set<String>();
  Set<String> uniqueColor = Set<String>();
  Set<String> uniqueUsageArea = Set<String>();
  Set<String> uniqueFaceGlosses = Set<String>();
  ValueNotifier<bool> hasLike = ValueNotifier<bool>(false);
  ValueNotifier<bool> hasAddedCart = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        dataId = context.routeArguments![0];
        debugPrint('${context.routeArguments![0]}');
        if (context.routeArguments?[1] != null) {
          data = context.routeArguments![1];
          debugPrint('${context.routeArguments![1]}');
        }
        AppLikeHelper.itWasLiked(data).then((value) => hasLike.value = value);
        AppCartHelper.itWasAddedCart(data).then((value) => hasAddedCart.value = value);
        Provider.of<ProductController>(context, listen: false).getProductByIdController(dataId).then((value) {});
      });
    } catch (e) {
      debugPrint('ProductDetailPage.initState() $e');
    }
  }

  @override
  void dispose() {
    hasLike.dispose();
    hasAddedCart.dispose();
    super.dispose();
  }

  String? languageControl(NameTextEntity nameTextEntity) {
    try {
      if (nameTextEntity != null) {
        if (localeNotifier.value!.languageCode.compareTo("en") == 0) {
          return nameTextEntity.en;
        } else {
          return nameTextEntity.tr;
        }
      }
    } catch (e) {
      return "null";
    }
    return null;
  }

  String getInitials(String? text) {
    if (text == null || text.isEmpty) {
      return '';
    }
    List<String> words = text.split(' ');
    List<String> initials = words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').toList();
    String joinText = initials.join();
    if (joinText.compareTo("P") == 0) {
      return "S";
    }
    return joinText;
  }

  void optimizing(ProductDetailData productDetailData) {
    uniqueSizes.clear();
    uniqueColor.clear();
    uniqueUsageArea.clear();
    uniqueFaceGlosses.clear();
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
            if (!uniqueColor.contains(element.faceColorId!.colorCode)) {
              uniqueColor.add(element.faceColorId!.colorCode!);
            }
          }

          // USAGE OPTIMIZATION
          if (element.usageArea != null) {
            element.usageArea!.forEach((elementUsage) {
              if (!uniqueUsageArea.contains(languageControl(elementUsage.name!))) {
                uniqueUsageArea.add(languageControl(elementUsage.name!)!);
              }
            });
          }

          // GLOSS OPTIMIZATION
          if (element.faceGlosses != null) {
            element.faceGlosses!.forEach((elementGlosses) {
              if (!uniqueFaceGlosses.contains(languageControl(elementGlosses.name!))) {
                uniqueFaceGlosses.add(languageControl(elementGlosses.name!)!);
              }
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    productDetailData = Provider.of<ProductController>(context, listen: true).productDetailData;
    optimizing(productDetailData);
    return (productDetailData.data != null)
        ? Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            bottomNavigationBar: (basketMode())
                ? ValueListenableBuilder(
                    valueListenable: hasAddedCart,
                    builder: (context, _, __) {
                      return ElevatedButton(
                        onPressed: () async {
                          AppCartHelper.cartToggle(data).then((value) {
                            hasAddedCart.value = value;
                          });
                        },
                        child: (hasAddedCart.value)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.cartShopping,
                                    color: AppColors.orangeS6,
                                  ),
                                  Text(context.translete('addedToCart'), style: context.textStyle.copyWith(color: AppColors.orangeS6)).wrapPaddingLeft(10)
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.cartShopping,
                                    color: Colors.white,
                                  ),
                                  Text(context.translete('addToCart'), style: context.textStyle.copyWith(color: Colors.white)).wrapPaddingLeft(10)
                                ],
                              ),
                      ).wrapPaddingAll(20);
                    })
                : SizedBox(),
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
                        onPressed: () async {
                          AppLikeHelper.likeToggle(data).then((value) {
                            hasLike.value = value;
                          });
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
            body: body(context, productDetailData),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget body(BuildContext context, ProductDetailData productDetailData) {
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
              Row(
                children: [
                  Text(context.translete("productProperties"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: SizedBox(
                    height: kToolbarHeight * 0.5 + 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueFaceGlosses.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: DecoratedBox(
                                decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  child: Text(getInitials(uniqueFaceGlosses.toList()[index])),
                                )).wrapPaddingRight(10));
                      },
                    ).wrapPaddingLeft(20),
                  ))
                ],
              ).wrapPaddingTop(20).wrapPaddingLeft(20),
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
                        return SizedBox(
                          height: kToolbarHeight * 0.5,
                          width: kToolbarHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Çerçevenin rengi
                                width: 1.0, // Çerçevenin genişliği
                              ),
                            ),
                            child: ColoredBox(color: uniqueColor.toList()[index].hexToColor()),
                          ),
                        ).wrapPaddingRight(10);
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
                  Expanded(child: Text(languageControl(productDetailData.data!.productTypeEntity!.name!)!, style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.w100)).wrapPaddingLeft(20)),
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
              Row(
                children: [
                  Text(context.translete("kullanimAlani"), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: SizedBox(
                    height: kToolbarHeight * 0.5 + 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueUsageArea.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: DecoratedBox(
                                decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  child: Text(uniqueUsageArea.toList()[index]),
                                )).wrapPaddingRight(10));
                      },
                    ).wrapPaddingLeft(20),
                  )),
                ],
              ).wrapPaddingTop(20).wrapPaddingLeft(20),
              Divider(),
              Text(context.translete('series'), style: context.theme.textTheme.bodyMedium!.copyWith(fontFamily: AppFont.oswald, fontSize: 26)).wrapPaddingLeft(20),
              featuresProducts(productDetailData.data!.features),
            ],
          ).wrapPaddingTop(20)
        ],
      ),
    );
  }

  Widget featuresProducts(List<Feature>? featureDatas) {
    return AspectRatio(
        aspectRatio: 0.75,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (featureDatas != null) ? featureDatas.length : 0,
          padding: EdgeInsets.only(left: 20),
          itemBuilder: (context, index) {
            final faceProductEntity = featureDatas![index];
            return SizedBox(
              width: context.width * 0.5,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.theme.colorScheme.surfaceTint.withOpacity(.25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: double.parse(faceProductEntity.faceSizeId!.width!) / double.parse(faceProductEntity.faceSizeId!.height!),
                        child: (faceProductEntity != null)
                            ? (faceProductEntity.images != null)
                                ? (faceProductEntity.images!.image != null)
                                    ? Image.network(faceProductEntity.images!.image!, alignment: Alignment.topCenter, fit: BoxFit.cover)
                                    : Center(child: CircularProgressIndicator())
                                : Center(child: CircularProgressIndicator())
                            : Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(faceProductEntity.name!.tr!),
                        Text(faceProductEntity.faceSizeId!.name!, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w200)),
                        SizedBox(
                          height: kToolbarHeight * 0.5 + 20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: faceProductEntity.faceGlosses!.length,
                            itemBuilder: (context, index) {
                              final data = faceProductEntity.faceGlosses![index];
                              return Center(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    child: Text(getInitials(languageControl(data.name!)!)),
                                  ),
                                ).wrapPaddingRight(10),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                appDialog(
                                  context,
                                  dialogType: DialogType.failed,
                                  showButtonForChild: false,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Text(faceProductEntity.name!.tr!, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                Text(faceProductEntity.faceSizeId!.name!, style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${context.translete('piece').toUpperCase()}/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.pieceInBox!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("M2/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.boxSize!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("M2/${context.translete('pallet').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.palletSize!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${context.translete('box').toUpperCase()}/${context.translete('pallet').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.boxInPallet!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("KG/${context.translete('box').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.boxWeight!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${context.translete('palletSize').toUpperCase()}", style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                                                  Text('${faceProductEntity.ebatlar!.palletDimensions!}', style: context.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300)).wrapPaddingLeft(20),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                context.translete('info'),
                                style: context.theme.textTheme.bodyMedium!.copyWith(color: AppColors.blueS3),
                              ).wrapPaddingRight(10)),
                        )
                      ],
                    ).wrapPaddingParametric(EdgeInsets.only(top: 10, left: 10, bottom: 10))
                  ],
                ),
              ),
            ).wrapPaddingRight(20);
          },
        )).wrapPaddingTop(20);
  }
}
