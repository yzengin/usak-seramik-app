import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/showreel_entity.dart';
import '../../Model/Request/get_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ShowreelService extends CrudService<ShowreelData> {
  static ShowreelService operations() {
    return ShowreelService();
  }

  Future<BaseResponse> getShowreelService() async {
    String token = bearerSessionTokenNotifier.value;
    debugPrint('token - $token ');
    return await getRequest(
      "$apiURL/sliders.php",
      bearerToken: token,
    );
  }
}
