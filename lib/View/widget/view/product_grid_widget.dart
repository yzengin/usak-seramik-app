import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';

import '../../../Controller/asset.dart';
import '../../../Rest/Entity/Product/product_entity.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({super.key, required this.data, required this.index});
  final ProductEntity data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.product_detail_page, arguments: [data.id]);
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
                          data.name ?? "".toUpperCase(),
                          style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white, fontFamily: AppFont.oswald),
                        ),
                        Divider(thickness: 0.2, color: Colors.white, height: 3),
                        Text(
                          '${data.faceCount} ${context.translete('face').toUpperCase()} ${data.colorCount} ${context.translete('color').toUpperCase()} ${data.sizeCount} ${context.translete('dimension').toUpperCase()}',
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

  String? imagePathControl({ImagesClass? imageEntity, bool? cover}) {
    try {
      if (imageEntity!.thumb != null && !cover!) {
        return imageEntity.thumb;
      } else {
        return imageEntity.cover;
      }
    } catch (e) {
      return "notImage";
    }
  }
}