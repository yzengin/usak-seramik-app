import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import 'package:usak_seramik_app/Rest/Service/Product/product_service.dart';
import '../../Entity/Product/product_detail_entity.dart';
import '../../Model/Response/base_response.dart';
import '/Controller/notifiers.dart';

class ProductController with ChangeNotifier {
  ProductData _productData = ProductData();
  ProductData get productData => _productData;
  set productData(ProductData data) => _productData = data;

  ProductDetailData _productDetailData = ProductDetailData();
  ProductDetailData get productDetailData => _productDetailData;
  set productDetailData(ProductDetailData data) => _productDetailData = data;

  Future<int> getProductController({int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productData = ProductData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductService(size: 20);
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

  Future<int> getProductByIdController(int id, {int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productDetailData = ProductDetailData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductByIdService(id);
      debugPrint('${response.body}');
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
    return status;
  }
}
