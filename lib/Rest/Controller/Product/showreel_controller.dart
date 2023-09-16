import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/showreel_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import 'package:usak_seramik_app/Rest/Service/Product/product_service.dart';
import '../../Model/Response/base_response.dart';
import '/Controller/notifiers.dart';

class ShowreelController with ChangeNotifier {
  ShowreelData _showreelData = ShowreelData();
  ShowreelData get showreelData => _showreelData;
  set showreelData(ShowreelData data) => _showreelData = data;

  Future<int> getShowreelController({int? page, int? size}) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      BaseResponse response = await ProductService.operations().getProductService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          showreelData = ShowreelData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ShowreelController.getShowreelController(), $e');
    }
    exceptedAction.value = false;
    return status;
  }
}
