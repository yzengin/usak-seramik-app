import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/persistent.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import 'package:usak_seramik_app/Rest/Service/Product/product_service.dart';
import '../../Entity/Product/product_detail_entity.dart';
import '../../Model/Response/base_response.dart';
import '/Controller/notifiers.dart';

class ProductController with ChangeNotifier {
  ProductData _productData = ProductData();
  ProductData _productSearchData = ProductData();
  ProductData get productData => _productData;
  set productData(ProductData data) => _productData = data;

  ProductData get productSearchData => _productSearchData;

  set productSearchData(ProductData value) {
    _productSearchData = value;
  }

  ProductDetailData _productDetailData = ProductDetailData();
  ProductDetailData get productDetailData => _productDetailData;
  set productDetailData(ProductDetailData data) => _productDetailData = data;

  Future<int> getProductController(ProductAttributesSearch productAttributesSearch, {int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productData = ProductData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductFilterService(productAttributesSearch, page: 0, size: 20);
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productData = ProductData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ProductController.getProductController(), $e');
    }
    exceptedAction.value = false;
    return status;
  }

  Future<int> getProductSearchController(ProductAttributesSearch productAttributesSearch, {int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productSearchData = ProductData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductFilterService(productAttributesSearch, page: 0, size: 24);
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productSearchData = ProductData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ProductController.getProductSearchController(), $e');
    }
    notifyListeners();
    exceptedAction.value = false;
    return status;
  }


  Future<int> getProductByIdController(int id, {int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productDetailData = ProductDetailData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductByIdService(id);
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productDetailData = ProductDetailData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ProductController.getProductByIdController(), $e');
    }
    exceptedAction.value = false;
    notifyListeners();
    return status;
  }
}


class ProductAttributesSearch extends Persistent{
  final List<int> faceColorId;
  final List<int> faceSizeId;
  final List<int> faceSurfaceId;
  final List<int> faceGlossId;
  final List<int> faceThicknessId;
  final List<int> faceStructureId;
  final List<int> productTypeId;
  final List<int> productUsagesId;

  ProductAttributesSearch({
    required this.faceColorId,
    required this.faceSizeId,
    required this.faceSurfaceId,
    required this.faceGlossId,
    required this.faceThicknessId,
    required this.faceStructureId,
    required this.productTypeId,
    required this.productUsagesId,
  });

  factory ProductAttributesSearch.fromJson(Map<String, dynamic> json) {
    return ProductAttributesSearch(
      faceColorId: (json['face_color_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      faceSizeId: (json['face_size_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      faceSurfaceId: (json['face_surface_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      faceGlossId: (json['face_gloss_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      faceThicknessId: (json['face_thickness_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      faceStructureId: (json['face_structure_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      productTypeId: (json['product_type_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      productUsagesId: (json['product_usages_id'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'face_color_id': faceColorId,
      'face_size_id': faceSizeId,
      'face_surface_id': faceSurfaceId,
      'face_gloss_id': faceGlossId,
      'face_thickness_id': faceThicknessId,
      'face_structure_id': faceStructureId,
      'product_type_id': productTypeId,
      'product_usages_id': productUsagesId,
    };
  }
}
