import 'package:usak_seramik_app/Rest/Entity/User/contact_entity.dart';
import '../../../Controller/notifiers.dart';
import '../../Model/Request/get_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ContactService extends CrudService<ContactData> {
  static ContactService operations() {
    return ContactService();
  }

  Future<BaseResponse> getContactService() async {
    return await getRequest("$apiURL/contacts.php", bearerToken: bearerSessionTokenNotifier.value);
  }
}
