import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Rest/Entity/User/contact_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Response/base_response.dart';
import '../../Model/Response/ok_response.dart';
import '../../Service/User/contact_service.dart';
import '/Controller/notifiers.dart';

class ContactController with ChangeNotifier {
  ContactData _contactEntity = ContactData();
  ContactData get contactEntity => _contactEntity;
  set contactEntity(ContactData data) => _contactEntity = data;

  Future<int> getContactController(int id) async {
    int status = 0;
    exceptedAction.value = true;
    try {
      BaseResponse response = await ContactService.operations().getContactService();
      status = response.statusCode;
      if (response is OkResponse) {
        if (response.body["data"] != null) {
          contactEntity = ContactData.fromJson(response.body);
        }
      }
    } catch (e) {
      debugPrint('ContactController.getContactController(), $e');
    }
    exceptedAction.value = false;
    return status;
  }
}
