import 'package:usak_seramik_app/Rest/Entity/User/message_entity.dart';
import '../../../Controller/notifiers.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class MessageService extends CrudService<MessageEntity> {
  static MessageService operations() {
    return MessageService();
  }

  Future<BaseResponse> send_message_service({required MessageEntity messageEntity}) async {
    return await postRequest(
      "$apiURL/send-message.php",
      bearerToken: bearerSessionTokenNotifier.value,
      entityData: messageEntity
    );
  }
}
