import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/User/message_entity.dart';
import 'package:usak_seramik_app/Rest/Service/User/message_service.dart';

import '../../Controller/notifiers.dart';
import '../Model/Response/base_response.dart';
import '../Model/Response/ok_response.dart';

class MessageHandler {
  static MessageHandler operations() {
    return MessageHandler();
  }

  Future<int> send_message_handler({required MessageEntity messageEntity}) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      BaseResponse response = await MessageService.operations().send_message_service(messageEntity: messageEntity);
      status = response.statusCode;
      if (response is OkResponse) {
        // ignore: unnecessary_null_comparison
        if (response.body != null) {
          // UserData.fromJson(response.body).data!;
        } else {
          status = 404;
        }
      } else {}
    } catch (e) {
      debugPrint('catch on registerHandler() $e');
    }
    exceptedAction.value = false;
    return status;
  }

}