import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import '../../../Controller/filter.dart';
import '../../../Model/data.dart';
import '../../Entity/Product/ProductFeatures/product_color_entity.dart';
import '../../Entity/Product/ProductFeatures/product_gloss_entity.dart';
import '../../Entity/Product/ProductFeatures/product_size_entity.dart';
import '../../Entity/Product/ProductFeatures/product_surface_entity.dart';
import '../../Entity/Product/ProductFeatures/product_types_entity.dart';
import '../../Entity/Product/ProductFeatures/product_usage_area_entity.dart';
import '../../Model/Response/base_response.dart';
import '../../Service/Product/product_features_service.dart';

class ProductFeaturesController with ChangeNotifier {
  // COLOR
  ProductColorData _productColorData = ProductColorData();
  ProductColorData get productColorData => _productColorData;
  set productColorData(ProductColorData data) => _productColorData = data;
  Future<int> getColorController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductColorsService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productColorData = ProductColorData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getColorController(), $e');
    }
    debugPrint('features color length: ${productColorData.data?.length}');
    if (productColorData.data != null) {
      productColorData.data!.forEach((element) {
        if (element != null) {
          colorFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: LabeledData(
                  data: element.colorCode!.hexToColor(),
                  label: element.name,
                  translate: true,
                ),
                isColor: true,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }

  // GLOSS
  ProductGlossData _productGlossData = ProductGlossData();
  ProductGlossData get productGlossData => _productGlossData;
  set productGlossData(ProductGlossData data) => _productGlossData = data;
  Future<int> getGlossController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductGlossesService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productGlossData = ProductGlossData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getGlossController(), $e');
    }
    debugPrint('features gloss length: ${productGlossData.data?.length}');
    if (productGlossData.data != null) {
      productGlossData.data!.forEach((element) {
        if (element != null) {
          glossFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: element.name,
                translate: true,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }

  // SIZE
  ProductSizeData _productSizeData = ProductSizeData();
  ProductSizeData get productSizeData => _productSizeData;
  set productSizeData(ProductSizeData data) => _productSizeData = data;
  Future<int> getSizeController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductSizesService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productSizeData = ProductSizeData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getSizeController(), $e');
    }
    debugPrint('features size length: ${productSizeData.data?.length}');
    if (productSizeData.data != null) {
      productSizeData.data!.forEach((element) {
        if (element != null) {
          sizesFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: element.name,
                translate: false,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }

  // SURFACE
  ProductSurfaceData _productSurfaceData = ProductSurfaceData();
  ProductSurfaceData get productSurfaceData => _productSurfaceData;
  set productSurfaceData(ProductSurfaceData data) => _productSurfaceData = data;
  Future<int> getSurfaceController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductSurfacesService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productSurfaceData = ProductSurfaceData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getSurfaceController(), $e');
    }
    debugPrint('features surface length:  ${productSurfaceData.data?.length}');
    if (productSurfaceData.data != null) {
      productSurfaceData.data!.forEach((element) {
        if (element != null) {
          surfaceFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: element.name,
                translate: true,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }

  // TYPE
  ProductTypesData _productTypesData = ProductTypesData();
  ProductTypesData get productTypesData => _productTypesData;
  set productTypesData(ProductTypesData data) => _productTypesData = data;
  Future<int> getTypeController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductTypesService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productTypesData = ProductTypesData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getTypeController(), $e');
    }
    debugPrint('features Type length: ${productTypesData.data?.length}');
    if (productTypesData.data != null) {
      productTypesData.data!.forEach((element) {
        if (element != null) {
          productTypeFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: element.name,
                translate: true,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }

  // USAGE AREA
  ProductUsageAreaData _productUsageAreaData = ProductUsageAreaData();
  ProductUsageAreaData get productUsageAreaData => _productUsageAreaData;
  set productUsageAreaData(ProductUsageAreaData data) => _productUsageAreaData = data;
  Future<int> getUsageAreaController() async {
    int status = 0;
    try {
      BaseResponse response = await ProductFeatureService.operations().getProductUsageAreaService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productUsageAreaData = ProductUsageAreaData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getUsageAreaController(), $e');
    }
    debugPrint('features usage length: ${productUsageAreaData.data?.length}');
    if (productUsageAreaData.data != null) {
      productUsageAreaData.data!.forEach((element) {
        if (element != null) {
          usageAreaFilter.add(
            ChooiceDataModel(
              context: LabeledData(
                data: element.id,
                label: element.name,
                translate: true,
              ),
              multiple: true,
            ),
          );
        }
      });
    }
    return status;
  }
}
