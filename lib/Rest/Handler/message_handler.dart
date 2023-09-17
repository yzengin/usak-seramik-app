import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/User/message_entity.dart';
import 'package:usak_seramik_app/Rest/Service/User/message_service.dart';

import '../../Controller/notifiers.dart';
import '../Model/Response/base_response.dart';
import '../Model/Response/ok_response.dart';

class AppMessageHandler {
  static AppMessageHandler operations() {
    return AppMessageHandler();
  }

  Future<int> sendMessageHandler({required MessageEntity messageEntity}) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      BaseResponse response = await MessageService.operations().send_message_service(messageEntity: messageEntity);
      status = response.statusCode;
      if (response is OkResponse) {
        // ignore: unnecessary_null_comparison
        if (response.body != null) {
          if(response.body["status"]!=null && response.body["status"]){
            status = 200;
          }else{
            status =  404;
          }
          // UserData.fromJson(response.body).data!;
        } else {
          status = 404;
        }
      } else {
        status = 404;
      }
    } catch (e) {
      debugPrint('catch on send_message_handler() $e');
    }
    exceptedAction.value = false;
    return status;
  }

}