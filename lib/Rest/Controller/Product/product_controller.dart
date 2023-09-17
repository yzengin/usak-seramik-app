import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import 'package:usak_seramik_app/Rest/Service/Product/product_service.dart';
import '../../Model/Response/base_response.dart';
import '/Controller/notifiers.dart';

class ProductController with ChangeNotifier {
  ProductData _productData = ProductData();
  ProductData get productData => _productData;
  set productData(ProductData data) => _productData = data;

  Future<int> getProductController({int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    if (page == 0) {
      productData = ProductData();
    }
    try {
      BaseResponse response = await ProductService.operations().getProductService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          productData = ProductData.fromJson(response.body);
          debugPrint('${productData.data}');
        }
      }
    } catch (e) {
      debugPrint('ProductController.getProductController(), $e');
    }
    exceptedAction.value = false;
    return status;
  }
}
