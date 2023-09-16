import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_filter_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/ok_response.dart';
import '../../Model/Response/base_response.dart';
import '../../Service/Dealer/dealer_service.dart';
import '/Controller/notifiers.dart';

class DealerController with ChangeNotifier {
  DealerData _dealerData = DealerData();
  DealerData get dealerData => _dealerData;
  set dealerData(DealerData data) => _dealerData = data;

  Future<int> getDealerController({required DealerFilterEntity dealerFilterEntity}) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      BaseResponse response = await DealerService.operations().getDealerService(dealerFilterEntity);
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          dealerData = DealerData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('DealerController.getDealerController(), $e');
    }
    exceptedAction.value = false;
    return status;
  }
}
