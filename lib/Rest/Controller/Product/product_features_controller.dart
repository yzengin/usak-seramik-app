import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/showreel_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import 'package:usak_seramik_app/Rest/Service/Product/showreel_service.dart';
import '../../Entity/Product/ProductFeatures/product_color_entity.dart';
import '../../Entity/Product/ProductFeatures/product_gloss_entity.dart';
import '../../Entity/Product/ProductFeatures/product_size_entity.dart';
import '../../Entity/Product/ProductFeatures/product_surface_entity.dart';
import '../../Entity/Product/ProductFeatures/product_types_entity.dart';
import '../../Entity/Product/ProductFeatures/product_usage_area_entity.dart';
import '../../Model/Response/base_response.dart';
import '../../Service/Product/product_features_service.dart';
import '/Controller/notifiers.dart';

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
          for(var dataIn in productUsageAreaData.data!){
            print('YESS tyşpeeee -- ${dataIn!.name!.tr}');
          }

        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getUsageAreaController(), $e');
    }
    return status;
  }
}
